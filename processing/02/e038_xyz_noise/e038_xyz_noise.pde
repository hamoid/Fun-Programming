float time = 0;

void setup() {
  size(400, 400);
}

void draw() {
  background(255);
  
  float x = 0;

  while (x < width) {
    line(x, 200 + 50 * noise(x / 100, time), x, height);
    x = x + 1;
  }
  
  time = time + 0.02;
}

