int n = 0;

void setup() {
  size(500, 400);
  background(255);
  frameRate(7);
  noStroke();
  fill(50, 200, 40);
}
void draw() {
  background(255);
  
  if(n % 2 == 0) {
    rect(0, 0, 100, 100);
  }
  if(n % 7 == 1) {
    rect(100, 0, 100, 100);
  }
  if(n % 7 == 2) {
    rect(200, 0, 100, 100);
  }
  n = n + 1;
}
