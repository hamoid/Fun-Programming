//  Infinite draggable space. Use your mouse to drag the screen.
ThingCollection t;
int margin = 80;
int startDragX;
int startDragY;
int deltaX = 0;
int deltaY = 0;
int totDeltaX = 0;
int totDeltaY = 0;
int CX;
int CY;

void setup() {
  size(480, 400);
  noStroke();
  smooth();
  colorMode(HSB, 1);
  t = new ThingCollection();
  CX = width / 2;
  CY = height / 2;
  noLoop();
  draw();
}
void draw() {
  background(0);
  t.draw(deltaX, deltaY);
}
void mousePressed() {
  loop();
  startDragX = mouseX;
  startDragY = mouseY;
}
void mouseDragged() {
  deltaX = mouseX - startDragX;
  deltaY = mouseY - startDragY;
}
void mouseReleased() {
  totDeltaX += deltaX;
  totDeltaY += deltaY;
  t.move(deltaX, deltaY);
  deltaX = 0;
  deltaY = 0;
  noLoop();
  save("a.png");
}
