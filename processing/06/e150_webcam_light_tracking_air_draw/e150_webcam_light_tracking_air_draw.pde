import processing.video.*;

Capture cam;

int x, y;

void setup() {
  size(640, 480);
  frameRate(30);
  background(0);
  //printArray(Capture.list());
  cam = new Capture(this, 640, 480, "/dev/video1", 30);
  cam.start();
}

// Light tracking
void draw() {
  if(cam.available()) {
    cam.read();
    cam.loadPixels();
    float maxBri = 0;
    int theBrightPixel = 0;
    for(int i=0; i<cam.pixels.length; i++) {
      if(brightness(cam.pixels[i]) > maxBri) {
        maxBri = brightness(cam.pixels[i]);
        theBrightPixel = i;
      }
    }
    x = theBrightPixel % cam.width;
    y = theBrightPixel / cam.width;
  }
  image(cam, 0, 0);
  fill(#FF0000);
  ellipse(x, y, 20, 20);

}

// Air draw
/*
void draw() {
  if(cam.available()) {
    cam.read();
    cam.loadPixels();
    loadPixels();
    for(int i=0; i<cam.pixels.length; i++) {
      if(brightness(cam.pixels[i]) > 200) {
        pixels[i] = color(255);
      }
    }
    updatePixels();
  }
}
*/