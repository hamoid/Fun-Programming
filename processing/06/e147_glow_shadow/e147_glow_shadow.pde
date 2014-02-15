
void setup() {
  size(675, 675);
  colorMode(HSB);
  rectMode(CENTER);
  frameRate(5);
}
void draw() {
  background(0);  
  for (int i=0; i<150; i++) {
    pushMatrix();
    translate(width/2, height/2);
    rotate(i);
    glowingRect((i % 5) * 25, (i%4) * 15, 120, 10, #22FF66, #FF6622, mousePressed);
    popMatrix();
  }
}
void glowingRect(float x, float y, float w, float h, color fillColor, color glowColor, boolean fxActive) {
  if (fxActive) {
    stroke(glowColor, 10);
    strokeWeight(4);
    rect(x, y, w, h);

    stroke(glowColor, 10);
    strokeWeight(9);
    rect(x, y, w, h);

    stroke(glowColor, 10);
    strokeWeight(16);
    rect(x, y, w, h);

    stroke(glowColor, 10);
    strokeWeight(25);
    rect(x, y, w, h);
  }

  noStroke();
  fill(fillColor);
  rect(x, y, w, h);
}

