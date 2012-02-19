float x[] = {};
float y[] = {};

void setup() {
  size(500, 400);
  background(255);
  noStroke();
}
void draw() {
  background(255);
  int i = 0;
  while(i < x.length) {
    if(random(20) > 17) {
      fill(255, 0, 0);
    } else {
      fill(0);
    }
    ellipse(x[i], y[i], 20, 20);
    x[i] = x[i] + random(-2, 2);
    y[i] = y[i] + random(-2, 2);
    i = i + 1;
  }
}
void mousePressed() {
  x = append(x, mouseX);
  y = append(y, mouseY);
}
