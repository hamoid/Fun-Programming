float diam = 100;
float a = 0;

void setup() {
  size(500, 400);
  background(0);
  noFill();
}
void draw() {
  background(0);
  
  float x = noise(a, 10) * width;
  float y = noise(a, 20) * height;

  float d = dist(x, y, mouseX, mouseY);
  
  if(d > diam) {
    strokeWeight(1);
  } else {
    strokeWeight(random(10));
  }
  
  stroke(255, 255, 0);
  ellipse(x, y, diam, diam);
  
  stroke(0, 255, 0);
  ellipse(mouseX, mouseY, diam, diam);
  
  a = a + 0.01;
}

