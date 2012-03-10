void setup() { 
  size(600, 600); 
  noStroke();
  frameRate(1);
}
// This function calls itself (it's a recursive function)
// It draws a rectangle, and randomly requests up to four 
// rectangles to be drawn inside.
void drawRect(float x, float y, float s) {
  // sometimes black, sometimes white
  fill(random(10) > 5 ? 0 : 255);
  
  rect(x, y, s+1, s+1);
  
  if (s >= random(100)) {
    drawRect(x, y, s/2);
  }
  if (s >= random(100)) {
    drawRect(x+s/2, y, s/2);
  }
  if (s >= random(100)) {
    drawRect(x, y+s/2, s/2);
  }
  if (s >= random(100)) {
    drawRect(x+s/2, y+s/2, s/2);
  }
}
void draw() {
  drawRect(0, 0, width);
}

