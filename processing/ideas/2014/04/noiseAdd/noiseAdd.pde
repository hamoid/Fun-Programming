PImage i;
float cOffset;
float sc;
void setup() {
  size(1280, 640, P2D);
  blendMode(ADD);
  background(0);
  cOffset = random(255);
}
void draw() {
  sc = 0.01 / (1 + frameCount / 30);
  i = createImage(width, height, RGB);
  i.loadPixels();
  for(int x=0; x<width; x++) {
    for(int y=0; y<height; y++) {
      float n = noise(x*sc, y*sc, frameCount*0.02);
      i.pixels[x + y * width] = n > 0.6 ? color(1, 4, 2) : color(0);
    }
  }
  i.updatePixels();
  image(i, 0, 0);
  print(".");
}
void keyPressed() {
  if(key == 's') {
    saveFrame();
  }
}
