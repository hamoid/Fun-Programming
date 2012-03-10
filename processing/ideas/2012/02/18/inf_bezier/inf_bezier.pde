// Create an continuous curve using bezier().

// Suppose we draw bezier curves using four points: p0, c0, c1, p1
// After drawing a curve, we start a new one by making the new p0 = old p1,
// and making the new c0 symmetrical to the old c1 respect to the old p1,
// resulting in a smooth transition.

float[] bx = new float[4];
float[] by = new float[4];
float t = 0;

void setup() {
  size(400, 400);
  background(255);
  smooth();
  fill(255, 20);
  
  for(int i = 0; i<4; i++) {
    bx[i] = random(width);
    by[i] = random(height);
  }
}
void draw() {
  rect(0, 0, width, height);
  
  float cx = bezierPoint(bx[0], bx[1], bx[2], bx[3], t);
  float cy = bezierPoint(by[0], by[1], by[2], by[3], t);
  
  strokeWeight(random(2, 6));
  point(cx, cy);
  
  t += 0.01;
  if (t > 1) {
    t = 0;
    bx[1] = bx[3] - (bx[2] - bx[3]);
    by[1] = by[3] - (by[2] - by[3]);
    bx[0] = bx[3];
    by[0] = by[3];
    bx[2] = random(width);
    by[2] = random(height);
    bx[3] = random(width);
    by[3] = random(height);    
  }
  
}
