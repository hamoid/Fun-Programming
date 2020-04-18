float oldx;
float oldy;
float a;
float w;

void reset() {
  oldx = width / 2;
  oldy = height / 2;
  a = random(TWO_PI);
  w = 1;
}

void setup() {
  size(500, 400);
  background(255);
  colorMode(HSB, 100);
  smooth();
  noFill();
  reset();
}
void draw() {
  stroke(30, 100, noise(w,a) * 100);
  strokeWeight(w);
  float newx = oldx + cos(a) * 5;
  float newy = oldy + sin(a) * 5;
  line(oldx, oldy, newx, newy);
  oldx = newx;
  oldy = newy;
  a = a + random(-0.4, 0.2);
  w = w + 0.1;
  
  if(oldx < 0 || oldy < 0 || oldx > width || oldy > height) {
    reset();
  }
}
