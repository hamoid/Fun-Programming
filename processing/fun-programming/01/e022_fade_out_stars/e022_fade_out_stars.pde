void setup() {
  size(400,300);
  background(0);
  noStroke();
}

void draw() {
  //background(0);
  fill(0, 50);
  rect(0, 0, width, height);
  
  fill(255);
  ellipse(random(width), random(height), 3, 3);
}

