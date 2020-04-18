float x = 0;

void setup() {
  size(400, 400);
  background(255);
  stroke(255);
}

void draw() {
  line(x, 200, x, 100);
  x = x + 1;

  if (x > width) {
    x = 0;
  }
  // sometimes we decide to change the line color
  if (random(100) > 70) {
    
    // now we decide if to use black or white
    if (random(100) > 50) {
      stroke(0);
    } 
    else {
      stroke(255);
    }
    
  }
}

