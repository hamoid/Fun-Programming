void setup() {
  size(400, 400);
  noFill();
}
void draw() {
  background(255);
  
  PVector a = new PVector(0, 200);
  PVector b = new PVector(mouseX-200, mouseY-200);
  
  stroke(200);
  line(200, 200, 200+a.x, 200+a.y);
  line(200, 200, 200+b.x, 200+b.y);
  
  float angFrom = atan2(b.y, b.x);
  float angTo = atan2(a.y, a.x);
  float ang = getTangent(angFrom, angTo);
  
  float c0x = 200+50*cos(ang);
  float c0y = 200-50*sin(ang);
  float c1x = 200+50*cos(ang+PI);
  float c1y = 200-50*sin(ang+PI);
  
  stroke(255, 0, 0);
  line(200, 200, c0x, c0y);  
  stroke(0, 255, 0);
  line(200, 200, c1x, c1y);  
  
  stroke(0);  
  bezier(200, 400, 200, 400, c1x, c1y, 200, 200);
  bezier(mouseX, mouseY, mouseX, mouseY, c0x, c0y, 200, 200);
}

float getTangent(float fromAngle, float toAngle) {
  float ang = HALF_PI-(fromAngle + toAngle) / 2;
  if(ang<0) {
   ang += PI;
  }
  return ang;
}
