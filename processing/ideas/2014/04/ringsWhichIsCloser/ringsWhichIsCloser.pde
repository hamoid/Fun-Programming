/*
    http://www.openprocessing.org/sketch/145581
 
 Simple rings made out of rectangles.
 A better idea would be using a PShape and adding vertices.
 I wonder if that can also be done with translate() and rotate()...
 */
void setup() {
  size(400, 400, P3D);
  noStroke();
  colorMode(HSB);
  rectMode(CENTER);
}
void draw() {
  background(255);
  ring(width/2-50, height/2, 120, 30, 0.3, color(255*1.0, 250, 210));
  ring(width/2+50, height/2, 120, 30, -0.3, color(255*0.2, 250, 210));
  ring(width/2, height/2-20, 120, 30, 1, color(255*0.1, 250, 210));
}
void ring(float x, float y, float radius, float sz, float rotX, int c) {
  pushMatrix();
  translate(x, y);
  rotateX(rotX);
  int steps = (int)(radius/2);
  for (int i=0; i<steps; i++) {
    rotateZ(TWO_PI/steps);
    float k = 0.5 + noise(sin(PI+i*TWO_PI/steps));
    fill(color(hue(c), saturation(c), brightness(c)*k));
    rect(radius, 0, sz, steps/3);
  }
  popMatrix();
}
