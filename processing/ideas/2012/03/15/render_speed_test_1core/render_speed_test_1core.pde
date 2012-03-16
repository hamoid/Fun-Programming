// 26 real fps, frameRate=27.48, 6000 op. per frame, req. frameRate: 100

int f = 0;

void setup() {
  size(600, 300);
  colorMode(HSB, 1);
  noStroke();
  smooth();
  frameRate(100);
}

void draw() {
  background(0);

  float fc = frameCount / 88.0;

  for (int y = 0; y < 10; y++) {
    float they = noise(y/10.0);
    for (int x=0; x < width; x++) {
      float thex = noise(x/50.0);
      fill((they + thex + fc) % 1.0, 1, 1);
      translate(x, 50+y*20);
      rotate(6*they - 6*thex - fc);
      rect(0, 0, 1, 15);
      resetMatrix();
    }
  }

  if (f++ % 300 == 299) {
    println((1000*f / millis()) + " real fps, frameRate=" + nfc(frameRate, 2) + 
      ", " + (10*width) + " op. per frame, req. frameRate: " + 100);
  }
}

