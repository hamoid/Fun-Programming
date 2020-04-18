/* @pjs preload="data/big.jpg"; */

// This program does not correctly work on processing.js.
// Please run inside the Processing IDE using the Java mode.

float d = 20;
PImage back_image;

void setup() {
  size(500, 400);
  background(#FF760D);
  noFill();
  stroke(255);
  smooth();
  back_image = loadImage("data/big.jpg");
}
void draw() {
  background(back_image);
  ellipse(mouseX, mouseY, d, d);
  if(mousePressed) {
    d++;
  }
}
void mouseReleased() {
  loadPixels();
  back_image.loadPixels();
  back_image.pixels = pixels;
  back_image.updatePixels();
  d = 20;
}

