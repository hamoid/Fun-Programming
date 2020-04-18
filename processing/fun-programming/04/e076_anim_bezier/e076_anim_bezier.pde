void setup() {
  size(500, 400);
  smooth();
  noFill();
}
void draw() {
  background(255);
  float t = frameCount / 100.0;
  for (int i = 0; i < 30; i++) {
    bezier(
      width/2, height, 
      width/2, noise(1, i, t)*height, 
      noise(2, i, t)*width, noise(4, i, t)*height, 
      noise(3, i, t)*width, noise(5, i, t)*height
    );
  }
}

