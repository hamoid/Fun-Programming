void setup() {
  colorMode(HSB);
  background(255);
  smooth();
  size(500, 500);
}
void spot(float xx, float yy) {
  translate(xx, yy);
  rotate(random(TWO_PI));
  scale(map(frameCount, 0, 2000, 1, 0.2));
  for (float i=0; i<=1; i += 0.005) {
    float x = map(i, 0, 1, -30, 30);
    // nice curve, 0 at extremes, 1 at middle. 
    // smaller 0.2 = sharper
    float s = pow(i, 0.2)*pow(1.0-i, 0.2);
    float y1 = -40*noise(i*3, 10+xx-yy)*s;
    float y2 = 40*noise(i*3, 20+xx-yy)*s;
    line(x, y1, x, y2);
  }
  resetMatrix();
}
void draw() {
    float x = random(100, width-100);
    float y = random(100,height-100);
    float d = dist(250, 250, x, y);
    if(d < 150) {
      stroke(random(30, 60), 20, 100+d);
    } else {
      stroke(255);
    }
    spot(x, y);
}

