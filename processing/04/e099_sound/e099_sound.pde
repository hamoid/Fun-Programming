import ddf.minim.*;

Minim minim;
AudioSample water;

int x = 130;
int y = 100;
int dx = 5;
int dy = 5;

void setup() {
  size(400, 300);
  fill(255, 0, 0);
  noStroke();
  smooth();
  
  minim = new Minim(this);
  water = minim.loadSample("water.wav", 2048);
}
void draw() {
  background(255);
  ellipse(x, y, 50, 50);
  x += dx;
  y += dy;
  
  if(x > width) {
    x = width;
    dx = -dx;
    water.trigger();
  }
  if(x < 0) {
    x = 0;
    dx = -dx;
    water.trigger();
  }
  if(y > height) {
    y = height;
    dy = -dy;
    water.trigger();
  }
  if(y < 0) {
    y = 0;
    dy = -dy;
    water.trigger();
  }
}
void stop() {
  water.close();
  minim.stop();  
  super.stop();
}
