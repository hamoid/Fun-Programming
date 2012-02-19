float x = 10;
float y = 10;
float a = 0;
float b = 0;

void setup() {
  size(500, 400);
  background(255);
  noStroke();
  smooth();
}

void draw() {  
  x = width / 2;
  y = height / 2;
  
  float x2 = sin(a) * 50;
  float y2 = cos(a) * 50;
  
  float x3 = sin(b) * 200;
  float y3 = cos(b) * 200;
    
  fill(255, 0, 0);
  ellipse(x + x2 + x3, y + y2 + y3, 10, 10);
  
  a = a + 0.1;
  b = b + 0.01;
}
