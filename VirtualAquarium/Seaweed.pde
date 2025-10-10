// Seaweed.pde
// Adds animated seaweed to the bottom of the aquarium for visual depth
// Images are free for non-commercial use (licensed for educational and personal use)
// ChatGPT assisted in refining the swaying logic for realistic motion

class Seaweed {
  // References and properties
  PApplet parent;   // Reference to main sketch for image handling
  float x;          // Horizontal position
  float baseY;      // Anchor point at bottom of tank
  float height;     // Seaweed height variation
  float swayOffset; // Phase offset for independent sway
  float depth;      // Used for rendering order
  PImage sprite;    // Seaweed image

  // Constructor initializes seaweed position, height, and random sprite
  Seaweed(PApplet parent, float x, float baseY) {
    this.parent = parent;
    this.x = x;
    this.baseY = baseY;
    this.height = random(20, 80);
    this.swayOffset = random(TWO_PI); // Unique sway phase per plant
    this.depth = random(0, 1);

    // Randomly select one of several seaweed sprites
    int index = (int) random(1, 5);
    sprite = parent.loadImage("seaweed" + index + ".png");
  }

  // Update sway animation each frame (gentle oscillation)
  void update() {
    swayOffset += 0.005 + noise(x * 0.01) * 0.002; // ChatGPT assisted logic combines sin wave and noise for natural sway
  }

  // Draw the seaweed with natural side-to-side motion
  void display() {
    float sway = sin(swayOffset) * 10; // Horizontal sway amplitude

    parent.pushMatrix();
    parent.translate(x + sway, baseY + height);
    parent.imageMode(CENTER);

    // Scale sprite based on height variation
    float scaleFactor = height / 100.0;
    parent.image(sprite, 0, 0, sprite.width * scaleFactor, sprite.height * scaleFactor);

    parent.popMatrix();
  }
}
