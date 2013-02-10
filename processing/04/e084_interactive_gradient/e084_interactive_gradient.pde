/* @pjs preload="data/screenshot.jpg"; */

PImage back;

void setup() {
  size(500, 400);
  colorMode(HSB, 100);
  noFill();
  smooth();
  strokeWeight(2);
  background(0);
  back = loadImage("data/screenshot.jpg");
  image(back, 0, 0);
}
void draw_circ_grad(int x, int y, int maxd) {
  color c1 = color(random(100), 100, 100);
  color c2 = color(random(100), 100, 30);

  for(int d = 0; d < maxd; d++) {
    float n = map(d, 0, maxd, 0, 1);
    color newc = lerpColor(c1, c2, n);
    stroke(newc);
    ellipse(x, y, d, d);
  }
}
void draw() {
}
void mousePressed() {
  draw_circ_grad(mouseX, mouseY, int(random(50, 300)));
}
