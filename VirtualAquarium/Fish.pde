// Fish.pde
// Handles fish movement, behavior, and visual representation
// Images are free for non-commercial use (licensed for educational and personal use)

class Fish {
  // Position and motion
  PVector pos;         // Current position
  PVector vel;         // Current velocity
  PVector targetDir;   // Desired direction

  // Visual and identity
  float size;
  String species;
  String name;
  PImage fishSprite;

  // Health and state
  float constitution;  // Represents fish vitality (0–100)
  float depth;         // Used for rendering depth order

  // Turning and orientation
  int nextTurnFrame;
  boolean facingLeft = false;
  float flipProgress = 1; // 1 = facing right, -1 = facing left
  float targetFlip = 1;   // Target direction for smooth flipping

  // Sprite resources
  final String[] SPRITE_NAMES = {
    "fish1.png", "fish2.png", "fish3.png", "fish4.png", "fish5.png",
    "fish6.png", "fish7.png", "fish8.png", "fish9.png", "fish10.png",
    "fish11.png", "fish12.png", "fish13.png", "fish14.png", "fish15.png"
  };

  // Constructor initializes fish with random appearance and motion
  Fish(float x, float y) {
    pos = new PVector(x, y);
    vel = PVector.random2D().mult(2);
    targetDir = vel.copy();
    size = random(25, 45);

    // Randomly select a sprite and assign a species
    int index = (int) random(SPRITE_NAMES.length);
    species = SPRITE_NAMES[index].replace(".png", "");
    fishSprite = loadImage(SPRITE_NAMES[index]);

    constitution = random(60, 100);
    depth = random(0, 1);
    scheduleNextTurn();
  }

  // Schedule a random future turn (every ~2–4 seconds)
  void scheduleNextTurn() {
    nextTurnFrame = frameCount + (int) random(120, 240);
  }

  // Core movement and behavior logic
  void update(ArrayList<Food> foodList, boolean predatorMode, float predatorX, float predatorY) {
    // Gradually lose constitution over time
    // Constitution was created from combining the original hunger and energy bars that were being drawn and used
    constitution = max(0, constitution - 0.01);

    // Adjust movement speed based on health
    float currentSpeed = map(constitution, 0, 100, 0.2, 3.0);

    // Predator avoidance (fish flee when predator mode is active)
    if (predatorMode) {
      PVector predator = new PVector(predatorX, predatorY);
      float distToPredator = PVector.dist(pos, predator);
      if (distToPredator < 250) {
        PVector fleeDir = PVector.sub(pos, predator);
        fleeDir.normalize();
        float fleeStrength = map(distToPredator, 0, 250, 10, 1.5);
        fleeDir.mult(fleeStrength);
        vel.add(fleeDir);
      }
    }

    // Locate the nearest food source
    Food target = null;
    float minDist = Float.MAX_VALUE;
    for (Food f : foodList) {
      float d = dist(pos.x, pos.y, f.getX(), f.getY());
      if (d < minDist) {
        minDist = d;
        target = f;
      }
    }

    // Swim toward nearby food and "eat" if close
    if (target != null && minDist < 200) {
      PVector dir = PVector.sub(new PVector(target.getX(), target.getY()), pos);
      dir.setMag(currentSpeed * 0.3);
      vel.add(dir);
      if (minDist < 10) {
        constitution = min(100, constitution + 20);
        foodList.remove(target);
      }
    }

    // Random turning at intervals
    if (frameCount >= nextTurnFrame) {
      targetDir = PVector.random2D();
      scheduleNextTurn();
    }

    // Smoothly blend direction changes
    vel.x = lerp(vel.x, targetDir.x * currentSpeed, 0.02);
    vel.y = lerp(vel.y, targetDir.y * currentSpeed, 0.02);

    // Natural wandering effect
    float wanderStrength = map(constitution, 0, 100, 0.01, 0.08);
    vel.x += random(-wanderStrength, wanderStrength);
    vel.y += random(-wanderStrength, wanderStrength);

    // Boundary avoidance (prevents swimming off-screen)
    float boundaryBuffer = 80;
    float coralLevel = height - 90;

    if (pos.x < boundaryBuffer && vel.x < 0) vel.x += random(0.5, 1.5);
    if (pos.x > width - boundaryBuffer && vel.x > 0) vel.x -= random(0.5, 1.5);
    if (pos.y > coralLevel - boundaryBuffer && vel.y > 0) vel.y -= random(0.5, 1.5);
    if (pos.y < boundaryBuffer && vel.y < 0) vel.y += random(0.5, 1.5);

    // Update position and constrain movement
    vel.y = constrain(vel.y, -3, 3);
    pos.add(vel);
    vel.limit(currentSpeed * 2);

    // Determine facing direction and flip smoothly
    float flipThreshold = 0.7;
    if (!facingLeft && vel.x < -flipThreshold) {
      facingLeft = true;
      targetFlip = -1;
    } else if (facingLeft && vel.x > flipThreshold) {
      facingLeft = false;
      targetFlip = 1;
    }
    flipProgress = lerp(flipProgress, targetFlip, 0.06);

    // Apply slight damping to prevent runaway speed
    vel.mult(0.99);

    // Keep fish within aquarium boundaries
    pos.x = constrain(pos.x, 40, width - 250);
    pos.y = constrain(pos.y, 40, height - 100);
  }

  // Draw the fish sprite and apply visual effects
  void display() {
    pushMatrix();
    translate(pos.x, pos.y);
    scale(flipProgress, 1);

    // Slight tilt based on vertical velocity for realism
    float tilt = constrain(vel.y * 0.05, -0.4, 0.4);
    rotate(tilt);

    imageMode(CENTER);

    // Desaturate color as constitution drops (visually shows poor health)
    if (constitution < 50) {
      float dullFactor = map(constitution, 50, 0, 0, 1);
      int dullColor = lerpColor(color(255, 255, 255), color(100, 100, 100), dullFactor);
      tint(dullColor);
    } else {
      noTint();
    }

    image(fishSprite, 0, 0, size * 2.0, size * 1.4);
    noTint();

    popMatrix();
    drawConstitutionBar();
  }

  // Displays a small health bar above each fish
  void drawConstitutionBar() {
    float barWidth = size;
    float barX = pos.x - barWidth / 2;
    float barY = pos.y - size / 2 - 8;

    noStroke();
    int barColor = lerpColor(
      color(255, 0, 0),
      color(0, 255, 0),
      constitution / 100.0
    );

    fill(barColor);
    rect(barX, barY, barWidth * (constitution / 100.0), 4);
  }
}
