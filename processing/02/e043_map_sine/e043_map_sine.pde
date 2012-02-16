float a = 0;

void setup() {
  size(400, 400);
  background(#BAFF0D);
  fill(#556F15);
  noStroke();
  smooth();
}
void draw() {
  background(#BAFF0D);

  float x = map(sin(a), -1, 1, 300, 400);

  ellipse(x, 200, 30, 30);
  
  a = a + 0.03;
}
