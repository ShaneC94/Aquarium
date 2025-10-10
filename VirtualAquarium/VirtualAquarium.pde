// VirtualAquarium.pde
// Creates an interactive virtual aquarium with animations, sounds, and user interactions
// Initially developed in IntelliJ IDE using the Processing library
// Later converted to the Processing IDE to meet project requirements
// Images are free for non-commercial use (licensed for educational and personal use)

import processing.sound.*;
import java.util.*;

// Global lists for aquarium objects
ArrayList<Fish> fishList;
ArrayList<Food> foodList;
ArrayList<Bubble> bubbleList;
ArrayList<Seaweed> seaweedList;
CoralBase coral;

// Environment variables
boolean isDay = true;
float bgBlend = 0; 
boolean predatorMode = false;
SoundFile aquariumAmbience;
PImage baseImage;

// Aquarium and HUD dimensions
final int HUD_WIDTH = 200;
final int AQUARIUM_WIDTH = 1280;
final int AQUARIUM_HEIGHT = 720;

// HUD data
String currentMessage = "Enjoy your visit!";
String[] fishNames = {
  "Bubbles", "Coral", "Finley", "Gill", "Splash", "Wavey", "Pearl", "Sunny", "Blue", "Nemo",
  "Marina", "Larry", "Drift", "Kit", "Luna", "Tide", "Keith", "Murphy", "Baldy", "Misty",
  "Guppy", "Bob", "Emma", "Shellby", "Franklin", "Zippy", "Sandy", "Matteas", "Opal", "Reef"
};
ArrayList<String> availableNames;

void settings() {
  // Aquarium width + side HUD
  size(AQUARIUM_WIDTH + HUD_WIDTH, AQUARIUM_HEIGHT);
  smooth();
}

void setup() { 
  // Initialize object lists
  fishList = new ArrayList<Fish>();
  foodList = new ArrayList<Food>();
  bubbleList = new ArrayList<Bubble>();
  seaweedList = new ArrayList<Seaweed>();
  
  // Shuffle fish names for variety each run
  availableNames = new ArrayList<String>(Arrays.asList(fishNames));
  Collections.shuffle(availableNames);

  // Load and loop ambient background sound
  aquariumAmbience = new SoundFile(this, "aquarium_ambience.wav");
  aquariumAmbience.loop();
  aquariumAmbience.amp(1);

  // Load coral base image
  baseImage = loadImage("base.png");
  coral = new CoralBase(baseImage, 0.5);

  // Generate seaweed across the bottom
  for (int i = 0; i < 3; i++) {
    float x = random(AQUARIUM_WIDTH);
    float y = AQUARIUM_HEIGHT - random(70, 100);
    seaweedList.add(new Seaweed(this, x, y));
  }

  // Spawn multiple fish with random positions and names
  for (int i = 0; i < 16; i++) {
    float x = random(AQUARIUM_WIDTH);
    float y = random(AQUARIUM_HEIGHT);
    Fish f = new Fish(x, y);
    f.name = availableNames.get(i);
    fishList.add(f);
  }
}

void draw() {
  updateBackground();

  pushMatrix();
  translate(HUD_WIDTH, 0); // Offset aquarium to make room for HUD

  // Draw coral background anchored to bottom
  if (baseImage != null) {
    imageMode(CORNER);
    float newWidth = AQUARIUM_WIDTH;
    float scale = newWidth / baseImage.width;
    float newHeight = baseImage.height * scale;
    tint(255, 235);
    image(baseImage, 0, AQUARIUM_HEIGHT - newHeight, newWidth, newHeight);
    noTint();
  }

  // Update and display bubbles
  spawnBubbles();
  for (int i = bubbleList.size() - 1; i >= 0; i--) {
    Bubble b = bubbleList.get(i);
    b.update();
    b.display();
    if (b.getY() < -20) bubbleList.remove(i);
  }

  // Update and display food pellets
  for (int i = foodList.size() - 1; i >= 0; i--) {
    Food f = foodList.get(i);
    f.update();
    f.display();
    if (f.getY() > AQUARIUM_HEIGHT - 80) foodList.remove(i);
  }

  // Update aquarium elements
  for (Seaweed c : seaweedList) c.update();
  for (Fish fish : fishList) fish.update(foodList, predatorMode, mouseX - HUD_WIDTH, mouseY);

  // Draw all objects with depth sorting
  // (ChatGPT assisted in refining the correct depth sort order)
  ArrayList<Object> drawList = new ArrayList<Object>();
  drawList.add(coral);
  drawList.addAll(fishList);
  drawList.addAll(foodList);
  drawList.addAll(seaweedList);
  drawList.addAll(bubbleList);
  
  drawList.sort((a, b) -> {
    float da = 0, db = 0;
    if (a instanceof CoralBase) da = ((CoralBase)a).depth;
    else if (a instanceof Fish) da = ((Fish)a).depth;
    else if (a instanceof Seaweed) da = ((Seaweed)a).depth;
    else if (a instanceof Bubble) da = ((Bubble)a).depth;
    else if (a instanceof Food) da = ((Food)a).depth;

    if (b instanceof CoralBase) db = ((CoralBase)b).depth;
    else if (b instanceof Fish) db = ((Fish)b).depth;
    else if (b instanceof Seaweed) db = ((Seaweed)b).depth;
    else if (b instanceof Bubble) db = ((Bubble)b).depth;
    else if (b instanceof Food) db = ((Food)b).depth;

    return Float.compare(da, db);
  });

  for (Object o : drawList) {
    if (o instanceof CoralBase) ((CoralBase)o).display();
    else if (o instanceof Seaweed) ((Seaweed)o).display();
    else if (o instanceof Fish) ((Fish)o).display();
    else if (o instanceof Bubble) ((Bubble)o).display();
    else if (o instanceof Food) ((Food)o).display();
  } // End ChatGPT-assisted section

  // Apply gradual night overlay transition
  noStroke();
  float overlayAlpha = map(bgBlend, 0, 1, 0, 180);
  fill(0, 0, 40, overlayAlpha);
  rect(0, 0, AQUARIUM_WIDTH, AQUARIUM_HEIGHT);

  popMatrix(); // Restore translation
  drawHUD();   // Draw side panel
}

// ---------- BACKGROUND ----------
void updateBackground() {
  // Smooth gradient background that transitions with day/night
  int dayTop = color(70, 180, 255);
  int dayBottom = color(0, 100, 200);
  bgBlend = lerp(bgBlend, isDay ? 0 : 1, 0.01);

  for (int y = 0; y < AQUARIUM_HEIGHT; y++) {
    float t = map(y, 0, AQUARIUM_HEIGHT, 0, 1);
    int gradColor = lerpColor(dayTop, dayBottom, t);
    stroke(gradColor);
    line(HUD_WIDTH, y, width, y);
  }
}

// ---------- HUD PANEL ----------
void drawHUD() {
  // Panel background and divider
  fill(0, 60, 90);
  noStroke();
  rect(0, 0, HUD_WIDTH, height);
  stroke(255, 80);
  line(HUD_WIDTH, 0, HUD_WIDTH, height);

  // Title and message
  fill(255);
  textAlign(LEFT, TOP);
  textSize(14);
  text("Virtual Aquarium", 10, 10);
  textSize(12);
  text(currentMessage, 10, 30);

  // Display fish and constitution bars
  int y = 60;
  for (int i = 0; i < fishList.size(); i++) {
    Fish f = fishList.get(i);
    if (y > height - 120) break; // Prevent overflow

    if (f.fishSprite != null) {
      imageMode(CENTER);
      image(f.fishSprite, 25, y + 10, 20, 10);
    } else {
      fill(200, 200, 255);
      ellipse(25, y + 10, 14, 8);
    }

    fill(255);
    textAlign(LEFT, CENTER);
    text(f.name, 45, y + 10);

    // Constitution bar (ChatGPT assisted)
    float hpPct = constrain(f.constitution / 100.0, 0, 1);
    float barX = 15, barY = y + 22, barW = HUD_WIDTH - 30, barH = 6;
    fill(50);
    rect(barX, barY, barW, barH);
    fill(lerpColor(color(255, 0, 0), color(0, 255, 0), hpPct));
    rect(barX, barY, barW * hpPct, barH);

    y += 26;
  } // End ChatGPT-assisted section
  
  // Display stats and controls
  int instructionY = height - 220;
  fill(255);
  textAlign(LEFT, TOP);
  textSize(11);
  text("Fish: " + fishList.size(), 10, instructionY);
  text("Food: " + foodList.size(), 10, instructionY + 15);
  text("Mode: " + (isDay ? "Day" : "Night"), 10, instructionY + 30);
  text("Predator Mode: " + (predatorMode ? "ON" : "OFF"), 10, instructionY + 45);

  text("Press 'N' → Day/Night", 10, instructionY + 65);
  text("Press 'P' → Predator", 10, instructionY + 80);
  text("Press 'R' → Reset", 10, instructionY + 95);
  text("Click or Press/Hold 'F' → Feed fish", 10, instructionY + 110);

  // Interactive buttons
  drawButton(10, height - 90, HUD_WIDTH - 20, 20, isDay ? "Switch to Night" : "Switch to Day");
  drawButton(10, height - 60, HUD_WIDTH - 20, 20, predatorMode ? "Predator: ON" : "Predator: OFF");
  drawButton(10, height - 30, HUD_WIDTH - 20, 20, "Reset Aquarium");
}

// Draws individual HUD buttons
void drawButton(float x, float y, float w, float h, String label) {
  fill(30, 100, 140);
  rect(x, y, w, h, 6);
  fill(255);
  textAlign(CENTER, CENTER);
  textSize(11);
  text(label, x + w/2, y + h/2);
}

// ---------- BUBBLES ----------
float bubbleOriginX = AQUARIUM_WIDTH - 110;
float bubbleOriginWidth = 25;

void spawnBubbles() {
  // Periodically spawn bubbles from filter area
  if (frameCount % 25 == 0) {
    float x = bubbleOriginX + random(-bubbleOriginWidth, bubbleOriginWidth);
    bubbleList.add(new Bubble(x, AQUARIUM_HEIGHT - 160));
  }
}

// ---------- INPUT ----------
void mousePressed() {
  // HUD button clicks
  if (mouseX < HUD_WIDTH) {
    if (mouseY > height - 90 && mouseY < height - 70) {
      isDay = !isDay;
      currentMessage = isDay ? "Day Mode" : "Night Mode";
    } else if (mouseY > height - 60 && mouseY < height - 40) {
      predatorMode = !predatorMode;
      currentMessage = predatorMode ? "Predator Mode ON" : "Predator Mode OFF";
    } else if (mouseY > height - 30 && mouseY < height - 10) {
      resetAquarium();
      currentMessage = "Aquarium Reset";
    }
  } else {
    // Feed fish on click
    for (int i = 0; i < 5; i++) {
      float fx = mouseX - HUD_WIDTH + random(-10, 10);
      float fy = mouseY + random(-10, 10);
      foodList.add(new Food(fx, fy));
    }
  }
}

// Keyboard shortcuts for quick mode changes
void keyPressed() {
  if (key == 'n' || key == 'N') {
    isDay = !isDay;
    currentMessage = isDay ? "Day Mode" : "Night Mode";
  }
  if (key == 'p' || key == 'P') {
    predatorMode = !predatorMode;
    currentMessage = predatorMode ? "Predator Mode ON" : "Predator Mode OFF";
  }
  if (key == 'r' || key == 'R') {
    resetAquarium();
    currentMessage = "Aquarium Reset";
  }
  if (key == 'f' || key == 'F') {
    float fx = mouseX - HUD_WIDTH + random(-10, 10);
    float fy = mouseY + random(-10, 10);
    foodList.add(new Food(fx, fy));
  }
}

// ---------- RESET ----------
void resetAquarium() {
  // Restart ambient sound if stopped
  if (aquariumAmbience != null) {
    if (aquariumAmbience.isPlaying()) aquariumAmbience.stop();
    aquariumAmbience.loop();
    aquariumAmbience.amp(1);
  }

  // Clear and rebuild scene
  fishList.clear();
  foodList.clear();
  bubbleList.clear();
  seaweedList.clear();

  predatorMode = false;
  isDay = true;
  bgBlend = 0;

  coral = new CoralBase(baseImage, 0.5);

  // Rebuild environment
  for (int i = 0; i < 3; i++) {
    float x = random(AQUARIUM_WIDTH);
    float y = AQUARIUM_HEIGHT - random(70, 100);
    seaweedList.add(new Seaweed(this, x, y));
  }

  Collections.shuffle(availableNames);
  for (int i = 0; i < 16; i++) {
    float x = random(AQUARIUM_WIDTH);
    float y = random(AQUARIUM_HEIGHT);
    Fish f = new Fish(x, y);
    f.name = availableNames.get(i);
    fishList.add(f);
  }
}

// ---------- CORAL ----------
class CoralBase {
  PImage img;
  float depth;

  CoralBase(PImage img, float depth) {
    this.img = img;
    this.depth = depth;
  }

  void display() {
    if (img != null) {
      imageMode(CORNER);
      float newWidth = AQUARIUM_WIDTH;
      float scale = newWidth / img.width;
      float newHeight = img.height * scale;
      image(img, 0, AQUARIUM_HEIGHT - newHeight, newWidth, newHeight);
    }
  }
}
