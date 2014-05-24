void setup() {
  size(200, 200);
  colorMode(HSB);
}
void draw() {
  loadPixels();
  int x = 0;
  float f = frameCount / 200.0;
  while(x < width) {
    int y = 0;
    while(y < height) {
      float n = 
        sin(f/1.35 + sin(y/199.1) * x/161.3 - y/323.7) * 
        sin(-f/1.73 - x/249.4 + sin(x/179.3) * y/118.7) *
        sin(f/1.21 + (y-x)/111.1);      
      n = sin(20 * n);
      pixels[x + y * width] = color(128 + 128 * n, 255, 255 );
      y = y + 1;
    }
    x = x + 1;
  }
  updatePixels();
}

