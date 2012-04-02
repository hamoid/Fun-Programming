void setup() {
  size(400, 400);
  smooth();
}
void draw() {
  background(255);

  float x = cos(frameCount / 1000.0) * 100;
  float y = sin(frameCount / 1000.0) * 100;

  translate(200, 200);

  // draw a normal red line
  stroke(200, 0, 0);
  line(0, 0, x, y);

  // draw a smooth blue line
  fill(0, 0, 200);
  sline(0, 0, y, x);
}

// Custom 2D line function that looks smoother than line()
// in Processing 1.5.1 or 2.0a5

// It's also much slower, since it involves translating and
// rotating a rectangle.
void sline(float x0, float y0, float x1, float y1) {
  noStroke();
  pushMatrix();
  translate(x0, y0);
  rotate(atan2(y1-y0, x1-x0));
  rect(0, 0, dist(x0, y0, x1, y1), 1);
  popMatrix();
}
