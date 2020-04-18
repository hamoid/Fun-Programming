float r = 0;

void setup() {
  size(400, 400);
  background(255);
  noStroke();
  fill(0);
  rectMode(CENTER);
}
void draw() {
  background(255);

  translate(100, 100);
  rotate(r);
  rect(0, 0, 80, 80);
  resetMatrix();

  translate(300, 100);
  rotate(r);
  rect(0, 0, 80, 80);
  resetMatrix();

  translate(100, 300);
  rotate(r);
  rect(0, 0, 80, 80);
  resetMatrix();

  translate(300, 300);
  rotate(r);
  rect(0, 0, 80, 80);
  resetMatrix();

  r = r + 0.02;
}

