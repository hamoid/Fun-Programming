Bug orecuho;

void setup() {
  size(400, 400);
  smooth();
  noStroke();
  fill(255);
  orecuho = new Bug(100, 100, 15);
}
void draw() {
  background(150, 0, 0);

  orecuho.live();
}
