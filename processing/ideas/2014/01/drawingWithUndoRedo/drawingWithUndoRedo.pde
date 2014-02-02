// Drawing program with undo/redo (OOP version)
// Press CTRL+Z to undo, CTRL+SHIFT+Z to redo

// We need these to know if CTRL/SHIFT are pressed
boolean controlDown = false;
boolean shiftDown = false;

Undo undo;

void setup() {
  size(500, 500);
  background(255);
  undo = new Undo(10);
}
void draw() {
  // Our two line drawing program
  if (mousePressed)
    line(mouseX, mouseY, pmouseX, pmouseY);
}
void mouseReleased() {
  // Save each line we draw to our stack of UNDOs
  undo.takeSnapshot();
}

void keyPressed() {
  // Remember if CTRL or SHIFT are pressed or not
  if (key == CODED) {
    if (keyCode == CONTROL) 
      controlDown = true;
    if (keyCode == SHIFT)
      shiftDown = true;
    return;
  } 
  // Check if we pressed CTRL+Z or CTRL+SHIFT+Z
  if (controlDown) {
    if (keyCode == 'Z') {
      if (shiftDown)
        undo.redo();
      else
        undo.undo();
    }
    return;
  } 
  // Check if we pressed the S key
  if (key=='s') {
    saveFrame("image####.png");
  }
}
void keyReleased() {
  // Remember if CTRL or SHIFT are pressed or not
  if (key == CODED) {
    if (keyCode == CONTROL) 
      controlDown = false;
    if (keyCode == SHIFT)
      shiftDown = false;
  }
}

