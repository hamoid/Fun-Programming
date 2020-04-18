int frames = 20;
int framesToSave = 0;
PGraphics pg[] = new PGraphics[frames];

void setup() {
  size(500, 500);
  prepareGraphics();
}
void draw() {
  int currFrame = frameCount % frames; // 0 .. 19
  if (mousePressed) {
    pg[currFrame].beginDraw();
    pg[currFrame].line(mouseX, mouseY, pmouseX, pmouseY);
    pg[currFrame].endDraw();
  }
  image(pg[currFrame], 0, 0);
  if (framesToSave > 0) {
    saveFrame("loop####.gif");
    framesToSave--;
  }
}
void keyPressed() {
  if (key == 's') {
    framesToSave = frames;
  }
  if (key == ' ') {
    prepareGraphics();
  }
}
void prepareGraphics() {
  for (int i=0; i<frames; i++) {
    pg[i] = createGraphics(width, height);
    pg[i].beginDraw();
    pg[i].background(0);
    pg[i].stroke(255);
    pg[i].strokeWeight(3);
    pg[i].endDraw();
  }
}

