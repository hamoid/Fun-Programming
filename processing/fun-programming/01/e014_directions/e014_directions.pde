float circle_x = 300;
float circle_y = 20;

void setup() {
  size(400, 200);
  stroke(#D60DFF);
  strokeWeight(7);
}
void draw() {
  background(#21EA73);
  ellipse(circle_x, circle_y, 40, 40);
  circle_x = circle_x - 2;
  circle_y = circle_y + 2;
}
