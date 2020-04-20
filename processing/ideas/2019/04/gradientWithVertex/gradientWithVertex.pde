void rndFillStroke() {
  fill(20 + 120*(int)random(2), 200, random(50, 200));
  stroke(20 + 120*(int)random(2), 100, random(50, 200));
}
void gradientRect(float x, float y, float w, float h) {
  beginShape();

  rndFillStroke();
  vertex(x, y);

  rndFillStroke();
  vertex(x+w, y);

  rndFillStroke();
  vertex(x+w, y+h);

  rndFillStroke();
  vertex(x, y+h);

  endShape(CLOSE);
}

void setup() {
  size(800, 800, P2D);
  colorMode(HSB);
  strokeWeight(5);
  background(40);

  // Make a grid of rectangles covering the screen
  // and maintaining a margin between rectangles and the borders of the window
  float m = 30;
  int cols = 3;
  int rows = 7;
  float w = width-m;
  float h = height-m;

  for (int x=0; x<cols; x++) {
    for (int y=0; y<rows; y++) {
      gradientRect(
        m+x*w/cols, 
        m+y*h/rows, 
        w/cols-m, 
        h/rows-m
        );
    }
  }
}
void draw() {
}
void keyPressed() {
    if(key =='s') { save("thumb.jpg"); println("saved!"); }
}
