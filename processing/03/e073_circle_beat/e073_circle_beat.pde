int csize = 50;
int grow = 0;
int n = 0;

void setup() {
  size(500, 400);
  noStroke();
  smooth();
  fill(255, 0, 0);
}

void draw() {
  background(255);
  
  if(n % 60 == 0) {
    grow = 5;
  }
  if(csize > 80) {
    csize = 80;
    grow = -2;
  }
  if(csize < 50) {
    csize = 50;
    grow = 0;
  }
  
  ellipse(250, 200, csize, csize);
  
  csize = csize + grow;
  n = n + 1;
}
