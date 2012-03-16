int f = 0;

void setup() {
  size(600, 300);
  colorMode(HSB, 1);
  noStroke();
  smooth();
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

  if (f++ % 50 == 0) { // 39 on 1.51, 26 on 2.0a4
    println((1000*f / millis()) + " : " + (1000*frameCount / millis()) + " : " + frameRate );
  }
}

