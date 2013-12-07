/*
  Inspired by Jimmy G., who asked
  
  << Just wondering if you have ever discussed "point scattering" within a certain shape?
   I used another tool called NodeBox before, with NodeBox, point Scattering and instance 
   copying is very easy as simply using a node.
   Do you think recreating from scratch in Processing would be easy? >>

  The idea is to have some invisible shapes, 
  then fill those shapes with other objects
  (blinking points in this example).
*/

PGraphics pg;

void setup() {
  size(500, 500);
  background(0);
  stroke(255);

  pg = createGraphics(500, 500);
  drawReferenceCanvas();
}
void draw() {
  // Fade the background to black
  fill(0, 10);
  rect(0, 0, width, height);
  
  // Try drawing some random points
  for(int i=0; i<200; i++) {
    // Choose a random point on the screen
    int x = int(random(width));
    int y = int(random(height));
    
    if(iShouldDrawPoint(x, y)) {
      point(x, y);
    }
  }  
}

// Draw whatever you want in this PGraphics object
void drawReferenceCanvas() {  
  pg.beginDraw();
  pg.fill(255);
  pg.textSize(150);
  pg.text("hello", 50, 300);
  // Here I could draw other shapes
  // ...
  pg.endDraw();
  pg.loadPixels();
}
boolean iShouldDrawPoint(int x, int y) {
  // Check if there is something at 
  // the reference canvas at point x, y
  return pg.pixels[x+y*pg.width] != 0;
  // I could use pg.get(x, y) != 0 
  // which is easier to understand, 
  // but much slower, specially in JavaScript.
}
