// initial position for our circle
float circle_x = 300;
float circle_y = 20;
// how much to move the circle on each frame
float move_x = 2;
float move_y = -2;

void setup() {
  size(400, 200);
  stroke(#D60DFF);
  strokeWeight(7);
}
void draw() {
  background(#21EA73);
  ellipse(circle_x, circle_y, 40, 40);
  circle_x = circle_x + move_x;
  circle_y = circle_y + move_y;
  
  if(circle_x > width) {
    circle_x = width;
    move_x = -move_x;
    println("too far right");
  }
  if(circle_y > height) {
    circle_y = height;
    move_y = -move_y;
    println("too far bottom");
  }
  if(circle_x < 0) {
    circle_x = 0;
    move_x = -move_x;
    println("too far left");
  }
  if(circle_y < 0) {
    circle_y = 0;
    move_y = -move_y;
    println("too far top");
  }
}
