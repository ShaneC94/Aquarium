// Food.pde
// Represents small food pellets that sink for fish to eat

class Food {
  // Pellet properties
  float x;       // X position
  float y;       // Y position
  float speed;   // Falling speed
  float depth;   // Used for rendering depth order
  int col;       // Pellet color

  // Constructor initializes position and random descent speed
  Food(float x, float y) {
    this.x = x;
    this.y = y;
    speed = random(0.5, 3);
    col = color(200, 150, 50); // Warm yellow-brown color
    depth = random(0, 1);
  }

  // Update position each frame (simulate sinking)
  void update() {
    y += speed;
  }

  // Draw the pellet on screen
  void display() {
    fill(col);
    noStroke();
    ellipse(x, y, 8, 8);
  }

  // Getters for position
  float getX() {
    return x;
  }

  float getY() {
    return y;
  }
}
