PImage photo;
float a = 0;

void setup() {
  size(300, 300);
  photo = loadImage("guitar_man.jpg");
  background(40);
  stroke(255);  
}
void draw() {
  int y = int(map(noise(a), 0, 1, 0, 200));
  
  copy(photo, 30, y, 150, 150, 0, 100, width, 100);
  line(0, 100, width, 100);
  line(0, 200, width, 200);
  
  a = a + 0.01;
}
