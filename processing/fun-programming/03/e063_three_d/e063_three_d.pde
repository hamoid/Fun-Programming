float a = 0;
float r = 0;

void setup() {
  size(400, 400, P3D);
}

void draw() {
  background(80);
  translate(mouseX, mouseY, map(noise(a), 0, 1, -400, 300));
  rotateY(r);
  box(50);
  a = a + 0.01;
  r = r + 0.02;
}

