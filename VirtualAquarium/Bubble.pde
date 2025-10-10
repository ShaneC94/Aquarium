// Bubble.pde
// Defines individual bubble objects that rise and drift within the aquarium

class Bubble {
  // Bubble properties
  float x;        // X position
  float y;        // Y position
  float speed;    // Vertical rise speed
  float drift;    // Horizontal drift (left/right)
  float size;     // Bubble diameter
  float depth;    // Used for rendering order
  int col;        // Bubble color (semi-transparent)

  // Constructor initializes bubble attributes randomly for natural variation
  Bubble(float x, float y) {
    this.x = x;
    this.y = y;
    speed = random(1, 3);
    drift = random(-0.3, 0.3);
    size = random(10, 20);
    depth = random(0, 1);
    col = color(190, 220, 255, 120); // Light blue with transparency
  }

  // Updates bubble position each frame
  void update() {
    y -= speed;  // Move upward
    x += drift;  // Slight side movement
  }

  // Renders the bubble on screen
  void display() {
    fill(col);
    noStroke();
    ellipse(x, y, size, size);
  }

  // Getter for Y-position (used to remove bubbles off-screen)
  float getY() {
    return y;
  }
}
