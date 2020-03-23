void setup() {
  size(800, 200);
  colorMode(RGB, 1.0);

  for(int x=0; x<width; x++) {
    float t = x * 0.01;
    float r = 0.5 + 0.5 * sin(t);
    float g = 0.5 + 0.5 * sin(t + TAU*0.33);
    float b = 0.5 + 0.5 * sin(t + TAU*0.66);
    stroke(r, g, b);
    line(x, 0, x, height);
  }
}
void draw() {
}
