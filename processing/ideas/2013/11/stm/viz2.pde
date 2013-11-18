/*
  2. Landscape
*/
void viz2() {
  drawGradient(#16282E, #000000);
  drawStars();

  pointLight(0, 0, 255, -3, 4, -3);
  pointLight(40, 33, 94, 6, 3, -3);

  camera(
  width*0.5, height*0.36, height*0.28, 
  width*0.5, height*0.28, 0, 
  0, 1, 0);

  pushMatrix();
  translate(width/2, height/2);
  rotateX(1);
  scale(700);

  for (int dy=0; dy<data.h; dy++) {
    for (int dx=0; dx<data.w; dx++) {
      float val = data.D[dx][dy];
      pushMatrix();
      translate(data.px(dx)-0.5, data.py(dy)-1);

      noStroke();
      fill((-60+val * 256) % 512, sin(val * 10) * 128 + 128, sin(val * 7) * 100 + 150);
      box(0.003, 0.003, val/2);

      if (val > data.topThreshold) {
        stroke(0, 255, 255, 40);
        strokeWeight(2/700.0);
        line(0, 0, 0, 0, 0, random(5));
      }
      popMatrix();
    }
  }
  popMatrix();

  rendered = true;
}

void drawGradient(color a, color b) {
  for (int y=0; y<height; y++) {
    stroke(lerpColor(a, b, y/float(height)));
    line(0, y, width, y);
  }
}

void drawStars() {
  for (int i=0; i<300; i++) {
    stroke(255, random(255));
    point(random(width), random(height), 1);
  }
}

