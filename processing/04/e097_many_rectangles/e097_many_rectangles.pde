int amt = 50;

int[] x1 = new int[amt];
int[] x2 = new int[amt];
int[] y1 = new int[amt];
int[] y2 = new int[amt];

color[] c = new color[amt];

color bgcolor;

void setup() {
  size(400, 300);
  colorMode(HSB, 100);
  rectMode(CORNERS);
  noStroke();
  
  bgcolor =  color(random(100), 30, 30);
  
  for(int i = 0; i < amt; i++) {
    x1[i] = int(random(width));
    x2[i] = x1[i] + int(random(20, 100));
    y1[i] = int(random(height));
    y2[i] = y1[i] + int(random(20, 100));
    c[i] = color(random(100), 80, 80);
  }
}
void draw() {
  background(bgcolor);
  for(int i = 0; i < amt; i++) {
    fill(c[i]);
    rect(x1[i], y1[i], x2[i], y2[i]);
  }
}
