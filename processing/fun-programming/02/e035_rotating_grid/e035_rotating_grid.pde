float rot = 0;

void setup() {
  size(400, 400);
  background(100, 200, 50);
  smooth();
  noStroke();
}
void draw_rotating_rectangle(float x, float y, float rect_size, float r) {
  translate(x, y);
  rotate(r);
  rect(0, 0, rect_size, rect_size);
  resetMatrix();
}
void draw() {
  background(100, 200, 50);

  float x = 0;
  while (x < 8) {
    float y = 0;
    while (y < 8) { 
      // we give a unique rotation amount to each rectangle, depending
      // on which column and row the rectangle is located (x and y)
      draw_rotating_rectangle(50 + x * 40, 50 + y * 30, 16, rot + x + y);
      y = y + 1;
    }
    x = x + 1;
  }
  rot = rot + 0.05;
}
