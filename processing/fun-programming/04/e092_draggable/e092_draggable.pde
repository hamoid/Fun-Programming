int x = 100;
int y = 100;
int sz = 100;
color bgcolor;

void setup() {
  size(400, 300);
  colorMode(HSB);
  noStroke();
  smooth();
  
  fill(random(255), 100, 200);
  bgcolor = color(random(255), 150, 255);
  background(bgcolor);
}
void draw() {
  background(bgcolor);
  
  if(dist(x,y, mouseX, mouseY) < sz / 2) {
    cursor(HAND);
    if(mousePressed) {
      x = mouseX;
      y = mouseY;
      strokeWeight(5);
    } else {
      strokeWeight(2);
    }
    stroke(255);
  } else {
    cursor(ARROW);
    noStroke();
  }
  
  ellipse(x, y, sz, sz);
}
