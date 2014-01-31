// Minimal drawing program with undo
// Press 'z' to undo

int levelsOfUndo = 10;
int currImageId = 0;
// circular array of images where to store undo levels
PImage[] images = new PImage[levelsOfUndo];

void setup() {
  size(500, 500);
  background(255);
  // Initialize all undo levels
  for(int i=0; i<levelsOfUndo; i++) {
    images[i] = createImage(width, height, RGB);
    // undo levels are initialized as copies of the blank screen
    images[i] = get();
  }
}
void draw() {
  if(mousePressed) {
    line(mouseX, mouseY, pmouseX, pmouseY);
  }
}
void mousePressed() {
  // increase the pointer of a circular array
  currImageId = (currImageId + 1) % levelsOfUndo;
}
void mouseReleased() {
  // save a copy of the display
  images[currImageId] = get();
}
void keyPressed() {
  if(key=='z') {
    // decrease the pointer of a circular array
    currImageId = (currImageId - 1 + levelsOfUndo) % levelsOfUndo;
    // bring back an old image
    image(images[currImageId], 0, 0);
  }
  if(key=='s') {
    saveFrame("image####.png");
  }
}
