// Run this program only in the Java mode inside the IDE,
// not on Processing.js (web mode)!!

// To convert images to a movie you can use:
// ffmpeg -i seq-%04d.tga -r 25 -threads 4 video.mp4

int c = 255;

void setup() {
  size(640, 480);
  background(0);
  frameRate(25);
  noStroke();
  rectMode(CENTER);
}
void draw() {
  fill(c, random(100));

  float sz = random(200);

  rect(random(width), random(height), sz, sz);

  if(frameCount % 200 == 0) {
    c = 255 - c; // 255 0 255 0 255 0 ..
  }
  saveFrame("frame-####.tif");

  if(frameCount > 500) { // 20 seconds * 25 fps = 500
    noLoop();
  }
}
