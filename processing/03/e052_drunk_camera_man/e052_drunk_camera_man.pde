/* @pjs preload="data/guitar_man.jpg"; */

PImage photo;
float a = 0;

void setup() {
  size(300, 300);
  photo = loadImage("data/guitar_man.jpg");
  background(40);
  stroke(255);
}
void draw() {
  int wi = int(map(noise(a+30), 0, 1, 50, 150));
  int he = int(map(noise(a+40), 0, 1, 50, 150));
  int x = int(map(noise(a+10), 0, 1, 0, photo.width-wi));
  int y = int(map(noise(a+20), 0, 1, 0, photo.height-he));

  copy(photo, x, y, wi, he, 0, 100, width, 100);
  line(0, 100, width, 100);
  line(0, 200, width, 200);

  a = a + 0.01;
}
