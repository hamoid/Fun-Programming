// Run this program only in the Java mode inside the IDE,
// not on Processing.js (web mode)!!

import processing.video.*;

Capture cam;

void setup() {
  size(600, 300);
  cam = new Capture(this, 320, 240, 30);
  cam.start();
}

void draw() {
  if(cam.available()) {
    cam.read();
  }
  image(cam, random(width), random(height));
}
