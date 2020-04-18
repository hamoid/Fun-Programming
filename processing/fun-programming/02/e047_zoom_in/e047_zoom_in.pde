void setup() {
  size(400, 400);
  background(#B1FF0A);
  noFill();
  smooth();
}
void draw() {
  if (random(100) > 50) {
    stroke(#B1FF0A);
  } else {
    stroke(#315500);
  }
  float r = random(100);
  ellipse(200, 200, r, r);
  copy(0, 0, width, height, -3, -2, width + 5, height + 3);
}
