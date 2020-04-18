/* @pjs preload="data/big.jpg"; */

void setup() {
  size(500, 400);
  colorMode(HSB);

  PImage img = loadImage("data/big.jpg");
  image(img, 0, 0);

  loadPixels();
  for(int i = 0; i<pixels.length; i++) {
    float b = brightness(pixels[i]);
    float s = saturation(pixels[i]);
    float h = hue(pixels[i]);

    if(b > 100) {
      pixels[i] = color(255);
    } else {
      pixels[i] = color(0);
    }
  }
  updatePixels();
}
void draw() {
}
