void setup() {
  // draw gradient
  for (int y=0; y<height; y++) {
    stroke(y*2, 255 - y*2, 0);
    line(0, y, width, y);
  }
  // draw black circle
  fill(0);
  noSmooth();
  text("click\nto\nerase\nblack\npixels", 20, 20);
}

// click to erase the circle
void mousePressed() {
  int black = color(0);
  loadPixels();
main: 
  for (int i=0; i<pixels.length; i++) {
    if (pixels[i] == black) {
      // A "precalculated lookup table of pixels
      // sorted by distance" would be more efficient
      // than this. Here pixels are tested multiple times
      // (better to repeat pixels than to miss some?)
      for (float dist=1; dist<width; dist+=0.6) {
        float aDelta = TAU / (3 + pow(dist, 2.1));
        for (float a=0; a<TAU; a += aDelta) {
          int x = (int)(dist * cos(a));
          int y = (int)(dist * sin(a));
          int pixelId = i + x + width * y;
          if (pixelId >= 0 && pixelId < pixels.length && pixels[pixelId] != black) {
            pixels[i] = pixels[pixelId];
            continue main;
          }
        }
      }
    }
  }
  updatePixels();
}

void draw() {
}

