float b = 0;
float co = 0;

void setup() {
  size(400, 400);
  background(#4A5C6F);
  colorMode(HSB, 100);
}

void draw() {
  copy(0, 0, width, height, 0, -1, width, height);

  float a = 0;
  float x = 0;
  float k1 = map(sin(1+b*0.31), -1, 1, 0.11, 2.1);
  float k2 = map(sin(2+b*0.47), -1, 1, 0.13, 2.3);
  float k3 = map(sin(3+b*0.71), -1, 1, 0.15, 2.5);
  float oldy = 0;
  while (x < width) {
    float y = map(sin(b*k1-a)*sin(a*k2+b*k3)*sin(a*k1-b), -1, 1, 300, 390);
    stroke(co, 70, map(y - oldy, -1, 1, 0, 100));
    line(x, y, x, height);
    x = x + 1;
    a = a + 0.0171;
    oldy = y;
  }
  b = b + 0.0183;
  co = co + 1;
  if (co > 100) {
    co = 0;
  }
}

