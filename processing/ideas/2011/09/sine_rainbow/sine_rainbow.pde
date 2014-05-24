void setup() {
  size(400, 400, P2D);
  colorMode(HSB);
}

float k(float n, float f) {
  return 10 + 100 * noise(n + f / 150);
}


void draw() {
  float y = 0;
  float f = float(frameCount);
  while (y < height) {
    stroke(
      128 + 128*sin(f / k(30, f) + y/k(10, f)), 
      128 + 128*sin(f / k(40, f) + y/k(20, f)), 
      128 + 128*sin(f / k(50, f) + y/k(10, f))
    );
    line(0, y, width, y);
    y = y + 1;
  }
}

