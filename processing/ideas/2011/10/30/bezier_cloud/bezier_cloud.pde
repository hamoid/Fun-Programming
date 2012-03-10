void setup() {
  size(500, 400);
  noFill();
  background(0);
  stroke(255, 10);
  smooth();
}
void draw() {
  float t = frameCount / 100.0;
  
  float x0 = width * noise(t,1);
  float y0 = height * noise(t,2);
  float x1 = width * noise(t,3);
  float y1 = height * noise(t,4);
  float x2 = width * noise(t,5);
  float y2 = height * noise(t,6);
  float x3 = width * noise(t,7);
  float y3 = height * noise(t,8);

  bezier(x0, y0, x1, y1, x2, y2, x3, y3);
}
