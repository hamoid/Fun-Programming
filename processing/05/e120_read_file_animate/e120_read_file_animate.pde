// Run this program only in the Java mode inside the IDE,
// not on Processing.js (web mode)!!

// Note for Windows users: replace \\ with / in your paths.
// For instance: loadBytes("C:/Users/Joe/pics/pic.jpg");
byte data[] = loadBytes("/home/funpro/audio/bcr2000/bcedit.ico");

void setup() {
  size(600, 100);
  colorMode(HSB);
}

void draw() {
  float filePos = map(mouseX, 0, width, 0, data.length-width);
  for (int i=0; i<width; i++) {
    int myhue = data[i+int(filePos)] & 0xff;
    stroke(myhue, 255, 255);
    line(i, 0, i, height);
  }
}

