void setup() {
  size(500, 400);
  background(#2D77EA);
}
void scene1() {
  ellipse(random(width), random(height), 100, 100);
}
void scene2() {
  rect(random(width), random(height), 100, 100);
}
void scene3() {
  float x = random(width);
  line(x, 0, x, height);
}
void draw() {
  background(#2D77EA);
  int m = millis();
  if(m < 2000) {
    scene1();
  } else if(m < 12000) {
    scene2();
  } else if(m < 17000) {
    scene3();
  } else {
    noLoop();
  }
}
