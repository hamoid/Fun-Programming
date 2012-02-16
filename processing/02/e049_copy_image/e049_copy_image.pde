PImage photo;

void setup() {
  size(300, 300);
  photo = loadImage("guitar_man.jpg");
  background(40);
  stroke(255);
}
void draw() {
  copy(photo, 30, 130, 150, 150, 0, 100, width, 100);
  line(0, 100, width, 100);
  line(0, 200, width, 200);
}
