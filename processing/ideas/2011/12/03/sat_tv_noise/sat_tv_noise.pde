float h;
float s;
float b;

void setup() {
  size(400, 300);
  colorMode(HSB, 100);
  h = random(100);
  s = random(100);
  b = random(100);
}
void draw() {
  for (int y = 0; y < height; y++) {
    float r = random(100);
    if (r < 33) {
      h = constrain(h + random(-1, 1), 0, 100);
    } 
    else if (r > 66) {
      s = constrain(s + random(-1, 1), 0, 100);
    } 
    else {
      b = constrain(b + random(-1, 1), 0, 100);
    }

    stroke(h, s, b);
    line(0, y, width, y);
  }
}

