void setup() {
  size(300, 300);
  background(#04B1CE);
  noFill();
  colorMode(HSB);
}

void draw() {
  strokeWeight(random(3, 10));
  stroke(random(255), 255, 255); // HSB Hue Saturation Brightness
  float rainbow_size = random(200, 270);
  ellipse(150, 350, rainbow_size, rainbow_size);
}
