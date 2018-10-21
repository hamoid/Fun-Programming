PShader fx;
Triangle t0, t1, t2, t3;
void setup() {
  size(600, 600, P2D);
  stroke(255);
  fx = loadShader("fx.frag");
  shader(fx);

  float rad = 100;
  t0 = new Triangle(rad, 0, 0);

  float a = 0;
  t1 = new Triangle(rad, rad*sin(a), rad*cos(a));
  t1.setOffset(rad*sin(PI+a), rad*cos(PI+a));

  a += TAU/3;
  t2 = new Triangle(rad, rad*sin(a), rad*cos(a));
  t2.setOffset(rad*sin(PI+a), rad*cos(PI+a));

  a += TAU/3;
  t3 = new Triangle(rad, rad*sin(a), rad*cos(a));
  t3.setOffset(rad*sin(PI+a), rad*cos(PI+a));
}

float calcAngle(int frame) {
  float t = (frame % 150) / 100.0;
  t = constrain(t, 0, 1);
  return PI/3 + easeInOut(t) * 4*PI/3;
}
void draw() {
  background(0);
  translate(width/2, height/2);  

  float a = calcAngle(frameCount);
  t1.setAngle(a);
  t2.setAngle(a);
  t3.setAngle(a);

  t0.draw();
  t1.draw();
  t2.draw();
  t3.draw();
}

float  easeInOut(float t) {
  if ((t*=2) < 1) return t*t*t*t/2;
  return -0.5 * ((t-=2)*t*t*t - 2);
}
