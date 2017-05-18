void setup() {
  size(600, 600, P3D);
  colorMode(HSB);
}
void keyPressed() {
  if (key == ' ') {
    background(#667788);
    translate(width * 0.5, height * 0.4, -180);
    rotateX(TWO_PI * 0.10);
    rotateZ(TWO_PI * 0.95);
    float pval = 0;
    for (int y=-300; y<300; y++) {
      for (int x=-300; x<300; x++) {
        float d = 0.1 * dist(x, y, 0, 0) ;
        float val = (0.5 + 0.5 * sin(d)) / (0.1 + d * 0.1);
        float h = (d * 10) % 256;
        float s = 255 - d * 8;
        float b = 256 * noise(x * 0.002, y*0.003, val) + 1500 * (val-pval);
        stroke(h, s, b);
        line(x, y, 60 * val, x, y, -30);
        pval = val;
      }
    }
  }
}
void draw() {
}