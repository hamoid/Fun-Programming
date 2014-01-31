// Minimal drawing program with undo (OOP version)
// Press 'z' to undo

Undo undo;

void setup() {
  size(500, 500);
  background(255);
  undo = new Undo(10);
}
void draw() {
  if (mousePressed) {
    line(mouseX, mouseY, pmouseX, pmouseY);
  }
}
void mouseReleased() {
  undo.save();
}
void keyPressed() {
  if (key=='z') {
    undo.load();
  }
  if (key=='s') {
    saveFrame("image####.png");
  }
}

class Undo {
  int levelsOfUndo;
  int currImageId = 0;
  // circular array of images where to store undo levels
  PImage[] images;
  Undo(int levels) {
    levelsOfUndo = levels;
    images = new PImage[levelsOfUndo];

    // Initialize all undo levels
    for (int i=0; i<levelsOfUndo; i++) {
      images[i] = createImage(width, height, RGB);
      // undo levels are initialized as copies of the blank screen
      images[i] = get();
    }
  }
  private void next() {
    // increase the pointer of a circular array
    currImageId = (currImageId + 1) % levelsOfUndo;
  }
  private void prev() {
    // decrease the pointer of a circular array
    currImageId = (currImageId - 1 + levelsOfUndo) % levelsOfUndo;
  }
  // save a copy of the display
  public void save() {
    next();
    images[currImageId] = get();
  }
  // bring an old image back
  public void load() {
    prev();
    image(images[currImageId], 0, 0);
  }
}

