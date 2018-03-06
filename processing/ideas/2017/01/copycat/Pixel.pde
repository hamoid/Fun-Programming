class Pixel {
  int x, y;
  float currentBrightness;
  float maxBrightness;
  float rotation;
  boolean state;
  Pixel(int x, int y) {
    this.x = x;
    this.y = y;
    maxBrightness = random(0.8, 1);
    rotation = random(-0.05, 0.05);
  }
  void update(boolean state) {
    this.state = state;
    if (state) {
      currentBrightness = min(currentBrightness + 0.1, 1);
    } else {
      currentBrightness = max(currentBrightness - 0.1, 0);
    }
  }
  void draw() {
    fill(lerpColor(lightGray, dirtyWhite, currentBrightness*maxBrightness+random(0.03)));
    if (state) {
      ellipse(x, y, pixelSize-1, pixelSize-1);
      fill(255, random(50));
      ellipse(x, y, pixelSize+4, pixelSize+4);
      fill(255, 100);
      ellipse(x-3, y-3, 2, 2);
    } else {
      pushMatrix();
      translate(x, y);
      rotate(rotation);
      rect(0, 0, pixelSize-4, pixelSize-4, 2,2,2,2);
      fill(255, 30);
      translate(-4, -4);
      ellipse(0, 0, 2, 2);
      popMatrix();     
    }
  }
}