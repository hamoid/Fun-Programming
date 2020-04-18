float x = 0;
 
void setup() {
  size(400, 400);
  fill(#529ED6);
  noStroke();
}
 
void draw() {
  translate(200, 200);
  background(#C9FF29);
 
  fill(255, 0, 0);
  // this circle moves at 1 pixel per frame
  ellipse(x, 0, 10, 10);
  
  fill(0, 255, 0);
  // this circle moves at 2 pixels per frame
  ellipse(x * 2, 40, 10, 10);
  
  fill(0, 0, 255);
  // this circle moves half pixel per frame
  ellipse(x * 0.5, 80, 10, 10);
  
  x = x + 1;
}
