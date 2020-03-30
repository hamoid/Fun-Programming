PShape donut;

void setup() {
  size(500, 500, P2D);
  smooth(8);
  donut = makeDonut(100, 200, 90);
  donut.setFill(color(255, 100));
  donut.setStroke(color(0, 100, 100));
  donut.setStrokeWeight(10);
}

void draw() {
  background(0, 100, 100);
  translate(width/2, height/2);
  rotate(radians(45));
  
  noStroke();
  fill(255, 200, 40);
  rect(-20, -300, 40, 600);
    
  shape(donut, 80 * sin(frameCount * 0.01), 0);
}

PShape makeDonut(float innerRadius, float outerRadius, float steps) {
  PShape s = createShape();
  s.beginShape();
  for (float a=0; a<TAU; a+=TAU/steps) {
    s.vertex(outerRadius*cos(a), outerRadius*sin(a));
  }
  s.beginContour();
  for (float a=0; a<TAU; a+=TAU/steps) {
    s.vertex(innerRadius*cos(-a), innerRadius*sin(-a));
  }
  s.endContour();
  s.endShape(CLOSE);
  return s;
}
