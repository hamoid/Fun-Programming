float d = 20;
PImage back_image;

void setup() {
  size(500, 400);
  background(#FF760D);
  noFill();
  stroke(255);
  smooth();
  back_image = loadImage("big.png");
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
  back_image.pixels = pixels;
  d = 20;
}

