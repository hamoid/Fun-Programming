void setup() {
  size(600, 600, P3D);
  colorMode(HSB);
}
void keyPressed() {
  if (key == ' ') {
    int t = millis();
    PVector v = new PVector();
    PVector lite = PVector.random3D();
    background(#ead5b3);
    noiseSeed(millis());
    noiseDetail(5);
    translate(width * 0.5, height * 0.5, -212);
    rotateX(1.5);
    rotateY(2.2);
    int sz = 300;
    float hueShift = random(100);
    float k1 = 2*(int)random(1, 4);
    float k2 = 2*(int)random(1, 4);
    float k3 = random(TWO_PI);
    float k4 = random(TWO_PI);
    for (float A=0; A<PI; A+=0.001) {
      float pval = 0;
      float r = sin(A);
      float step = TWO_PI / (1 + 1000 * r);
      for (float B=0; B<TWO_PI; B+=step) {
        v.x = sin(A) * cos(B);
        v.y = sin(A) * sin(B);
        v.z = cos(A);
        float n = v.dot(lite);
        float vv = noise(0.6 * sin(hueShift + k1*A*sin(B-n)), 0.3 * sin(B*sin(n)), hueShift) +
          0.5 * sin(v.x * k3) * sin(v.y * k1 - v.z * k4);
        float val = sz - 246 * pow(vv, 4);
        float h = hueShift + val + 20 * n;
        float s = 100 + 84 * cos(hueShift + h * 0.03);
        h = h % 256;
        float b = 100 + val * 0.2 + 212 * (noise(sin(B*2),cos(A*2)) - 0.5) + 24 * (val - pval) + 50 * n;
        stroke(h, s, b);
        v.mult(val);
        line(0, 0, 0, v.x, v.y, v.z);
        pval = val;
      }
    }
    println(millis()-t, "ms");
  }
  if(key == 's') {
    save(millis() + ".png");
  }
}
void draw() {}