color c1;
color c2;

void setup() {
  size(500, 400);
  colorMode(HSB, 100);
  
  c1 = color(random(100), 100, 100);
  c2 = color(random(100), 100, 30);
  
  for(int y = 0; y < height; y++) {
    float n = map(y, 0, height, 0, 1);
    color newc = lerpColor(c1, c2, n);
    stroke(newc);
    line(0, y, width, y);
  }
}
void draw() {
}
