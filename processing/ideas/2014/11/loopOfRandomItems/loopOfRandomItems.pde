PVector[] points;
int loopFrames = 200;
void setup() {
  size(600, 600, P3D);
  stroke(255);
  points = new PVector[900];
  for(int i=0; i<points.length; i++) {
    points[i] = new PVector(random(width), random(height), random(width));
  }
}

void draw() {
  float t = (frameCount % loopFrames) / (float) loopFrames;
  background(0);
  for(PVector p : points) {
    point(p.x - width * t, p.y, p.z);
    point(p.x - width * t + width, p.y, p.z);
  }  
}
