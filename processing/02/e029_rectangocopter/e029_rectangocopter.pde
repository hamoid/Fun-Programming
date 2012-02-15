float r = 0;
float backR;
float backG;
float backB;

void setup() {
  size(400, 400);
  backR = random(0, 100);
  backG = random(0, 100);
  backB = random(0, 100);
  
  background(backR, backG, backB);
  rectMode(CENTER);
  
  noStroke();
  smooth();
}

void draw() {
  fill(backR, backG, backB, 50);
  rect(width/2, height/2, width, height);

  fill(255);
  translate(mouseX, mouseY);
  rotate(r);
  rect(0, 0, 100, 100);
  
  r = r + 0.05;
}
