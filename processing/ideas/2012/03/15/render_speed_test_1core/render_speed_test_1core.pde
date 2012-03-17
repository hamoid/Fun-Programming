//12 real fps, frameRate=13.68, 10000 op. per frame, req. frameRate: 100

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

  float pTime = frameCount / 88.0;

  int i;
  for (i = 0; i <= 9999; i++) {
    float x = width*sin(i / 100.0 + pTime)*0.4;
    float y = height*cos(i / 100.0 + pTime)*0.4;
    float r = noise(x/20, y/20, pTime);
    fill(r*1.3, 1, 1);
    translate(width/2 + x, height/2 +y);
    rotate(10*r);
    rect(0, 0, 1, 30);
    resetMatrix();
  }

  if (f++ % 200 == 99) {
    println(nfc(1000.0*f / millis(), 1) + " real fps, frameRate=" + nfc(frameRate, 1) + 
      ", " + i + " op. per frame, req. frameRate: " + 100);
  }
}

