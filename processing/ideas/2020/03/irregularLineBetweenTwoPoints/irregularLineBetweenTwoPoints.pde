PVector a = new PVector();
PVector b = new PVector();
void setup() {
  size(800, 800, P2D);
}

void draw() {
  background(0);
  
  noFill();
  blendMode(ADD);
  stroke(100);
  translate(width * 0.5, height * 0.5);
  for (float ang=0; ang<TAU; ang+=TAU/90) {
    PVector a = PVector.mult(PVector.fromAngle(ang + 1.5), 100);
    float r = min(1/abs(cos(ang)), 1/abs(sin(ang)));
    PVector b = PVector.mult(PVector.fromAngle(ang), r * 380);
    beginShape();
    for (float p=0; p<=1; p+=0.003) {
      PVector point = fromIrregularLine(a, b, p);
      vertex(point.x, point.y);
    }
    endShape();
  }
  if(key == 's') { save("thumb.jpg"); }
}

float weightedRnd05() {
  float r = random(1);
  return (r*r*(random(1) < 0.5 ? 1 : -1))*0.5 + 0.5;
}

PVector fromIrregularLine(PVector a, PVector b, float p) {
  float offset = cos(p*TAU-PI)*0.5 + 0.5;
  float distance = a.dist(b) * 0.5;
  float t = millis() * 0.0002;
  PVector point = PVector.lerp(a, b, p);    
  point.x += distance*(noise(point.y*0.01 - t, point.x*0.01)-0.48) * offset;
  point.y += distance*(noise(point.x*0.01 + t, point.y*0.01)-0.48) * offset;
  return point;
}
