float x = 100;
float y = 100;
float sz = 100;
color bgcolor;

float current_weight = 2;
float target_weight = 2;

float current_alpha = 0;
float target_alpha = 0;

void setup() {
  size(400, 300);
  colorMode(HSB);
  noStroke();
  smooth();
  
  fill(random(255), 100, 200);
  bgcolor = color(random(255), 150, 255);
  background(bgcolor);
}
void draw() {
  background(bgcolor);
  
  if(dist(x,y, mouseX, mouseY) < sz / 2) {
    if(mousePressed) {
      cursor(MOVE);
      x = lerp(x, mouseX, 0.2);
      y = lerp(y, mouseY, 0.2);
      target_weight = 10;
    } else {
      cursor(HAND);
      target_weight = 5;
    }
    target_alpha = 255;
  } else {
    cursor(ARROW);
    target_alpha = 0;
  }
  
  current_weight = lerp(current_weight, target_weight, 0.2);
  strokeWeight(current_weight);
  
  current_alpha = lerp(current_alpha, target_alpha, 0.2);
  stroke(255, current_alpha);
  
  ellipse(x, y, sz, sz);
}
