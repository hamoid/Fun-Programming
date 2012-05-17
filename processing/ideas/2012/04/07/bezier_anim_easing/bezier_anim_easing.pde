/*
  This program demonstrates the effect of the two control points
  on bezierPoint(). Depending on those two values, the ball will
  spend more time at one of the ends, at both, or maybe at the
  center.
  The vertical position of the mouse affects the second control
  point. The horizontal position of the mouse affects the first
  control point.
*/
int hparts = 7;
int vparts = 7;

float w;
float h;

void setup() {
  size(600, 600);
  background(255);
  smooth();

  w = width / float(hparts);
  h = height / float(vparts);
  
  for(float x=0; x<hparts; x++) {
    for(float y=0; y<vparts; y++) {        
      for(float z=0; z<=1; z+=0.03) {
        float xx = 5 + x*w + (w-10)*bezierPoint(0, x/(hparts-1), y/(vparts-1), 1, z);
        stroke(0, 100);
        line(xx, y*h+5, xx, y*h+h-10);
      }
    }
  }
  noStroke();
}
void draw() {
  float loopLength = 100.0;
  float t = frameCount % loopLength /loopLength;
  
  fill(255);
  rect(0, h*4 - 9, width, 12);
  
  float c0 = mouseX/float(width);
  float c1 = mouseY/float(height);
  float xx = width * bezierPoint(0, c0, c1, 1, t);

  fill(120);
  text("bezierPoint(0, " + nfc(c0, 2) + ", " + nfc(c1, 2) + ", 1, " + t + ")", 20, h*4+1);
  text("hold mouse over one rectangle", 390, h*4+1);

  fill(255, 0, 0);
  ellipse(xx, h*4-3, 7, 7);
}
