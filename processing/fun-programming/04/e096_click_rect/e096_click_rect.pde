int x1 = 100;
int y1 = 50;
int x2 = 300;
int y2 = 100;

color bgcolor;
color fgcolor;

void newcolor() {
  float h = random(100);
  bgcolor = color(h, 50, 30);
  fgcolor = color(h, 80, 100);
  fill(fgcolor);
  noStroke();
}

void setup() {
  size(400, 300);
  colorMode(HSB, 100);
  rectMode(CORNERS);
  newcolor();
}
boolean inside() {
  return mouseX > x1 && mouseX < x2 && mouseY > y1 && mouseY < y2;
}
void draw() {
  background(bgcolor);
  
  if(inside() && mousePressed) {
    newcolor();
  }
  
  rect(x1, y1, x2, y2);
}
