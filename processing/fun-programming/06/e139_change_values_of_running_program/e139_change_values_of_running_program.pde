void setup() {
  size(400, 400);
  noStroke();
  rectMode(CENTER);
}
void draw() {
  fill(224, 74, 40);
  background(236, 211, 95);
  for(int y=42; y<height; y+=45) {
    for(int x=34; x<height; x+=27) {
      resetMatrix();
      translate(x, y);
      rotate(TWO_PI * noise(x/270.5, y/234.6, frameCount / 70.8));
      rect(0, 0, 22, 26);
    }
  }
}
