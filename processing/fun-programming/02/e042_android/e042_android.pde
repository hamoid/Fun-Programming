void setup() {
  background(0);
  colorMode(HSB);
}
void draw() {
  fill(0, 10);
  noStroke();
  rect(0, 0, width, height);
  
  stroke(random(255), 255, 255);
  float x = random(width);
  line(x, 0, x, height);
}
