void setup() {
  size(400, 400);
  background(255);
  stroke(0);
  noFill();
  for(int i=0; i<10; i++) {
    float r = random(50, 200);
    ellipse(random(width), random(height), r, r);
  }
}
void mousePressed() {
  if (mouseButton == RIGHT) {
    new Flood(mouseX, mouseY, #C6C484, #FFFFFF, 5000000);
  }
}
void keyPressed() {
  if(key == 's') {
    save("thumb.png");
  }
}
void draw() {
}
