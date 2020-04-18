float circle_x = 0;

void setup() {
  size(400,400);
  
  noStroke();
  fill(#C1FF3E);
}

void draw() {
  background(#1BB1F5);
    
  ellipse(circle_x,50, 50, 50);
  
  circle_x = circle_x + 1;
}
