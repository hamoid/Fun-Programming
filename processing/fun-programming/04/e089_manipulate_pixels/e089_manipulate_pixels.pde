/* @pjs preload="data/big.jpg"; */

void setup() {
  size(500, 400);

  PImage img = loadImage("data/big.jpg");
  image(img, 0, 0);

  loadPixels();
  for(int i = 0; i < pixels.length; i++) {
    float r = red(pixels[i]);
    float g = green(pixels[i]);
    float b = blue(pixels[i]);

    pixels[i] = color(g, b, r);
  }
  updatePixels();
}
void draw() {
}
