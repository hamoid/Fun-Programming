float r = 0;

void setup() {
  size(400,400);
  background(10);
  smooth();
  noStroke();
}
void draw() {
  translate(width/2, height/2);
  fill(255);
  rotate(r);
  float circle_size = random(5, 15);
  ellipse(100 + r, 10, circle_size, circle_size);
  r = r + 0.2;
  println(r);
}
