PVector p1, p2;
float t = 0;

void setup() {
  size(400, 400);
  noStroke();
  smooth();
  p1 = new PVector(random(width), random(height));
  p2 = new PVector(random(width), random(height));
}
void draw() {
  background(100);
  float a = map(t, 0, 1, PI, TWO_PI);
  float sz = map(sin(a), 0, -1, 10, 90); 
  float c = map(cos(a), -1, 1, 0, 1);
  float x = lerp(p1.x, p2.x, c);
  float y = lerp(p1.y, p2.y, c);
  ellipse(x, y, sz, sz);
  
  if(t > 1) {
    noLoop();
  }
  t += 0.01;
}

void mousePressed() {
  p1.set(p2);
  p2 = new PVector(mouseX, mouseY);
  t = 0;
  loop();  
}
