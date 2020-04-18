float[] x = new float[100];
float[] y = new float[100];
float[] speed = new float[100];

void setup() {
  size(500, 400);
  background(0);
  stroke(255);
  noCursor();

  int i = 0;
  while(i < 100) {  
    x[i] = random(0, width);
    y[i] = random(0, height);
    speed[i] = random(1, 5);
    i = i + 1;
  }
}

void draw() {
  background(0);

  // draw triangle
  triangle(mouseX, mouseY-6, mouseX, mouseY+6, mouseX+30, mouseY);
  
  int i = 0;
  while(i < 100) {
    float co = map(speed[i], 1, 5, 100, 255);
    stroke(co);
    strokeWeight(speed[i]);
    point(x[i], y[i]);
  
    x[i] = x[i] - speed[i] / 2;
    if(x[i] < 0) {
      x[i] = width;
    }
    i = i + 1;
  }
}
