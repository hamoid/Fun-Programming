
void setup() {
  size(400, 400);
  background(0);
  stroke(255);
  fill(255);
  textSize(80);
}
void draw() {
  fill(random(255), random(255), random(255));
  ellipse(random(width), random(height), 40, 40);
  filter(BLUR, 2);
}
