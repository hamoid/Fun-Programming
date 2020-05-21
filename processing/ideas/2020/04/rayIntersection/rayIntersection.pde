class Ray {
  PVector start;
  PVector direction;
  float angle;
  Ray(float ox, float oy, float nx, float ny) {
    start = new PVector(ox, oy);
    direction = new PVector(nx, ny);
  }
  void rotate(float angleInc) {
    angle += angleInc;
    PVector.fromAngle(angle, direction); // update direction
  }
  void draw() {
    stroke(0);
    line(start.x, start.y, start.x + direction.x * 2000, start.y + direction.y * 2000);
  }
}
Ray a, b;
void setup() {
  size(800, 800);
  noFill();
  a = new Ray(200, 200, 1, 0);
  b = new Ray(600, 600, 1, 0);
}
void draw() {
  background(255);
  noStroke();
  fill(240);
  rect(0, 0, width/2, height);
  
  a.draw();
  b.draw();
  PVector i = intersectRays(b, a);
  if(i != null) {
    fill(#FF0000);
    circle(i.x, i.y, 20);
  }
}
PVector intersectRays(Ray a, Ray b) {
  PVector d = PVector.sub(b.start, a.start);
  float det = b.direction.x * a.direction.y - b.direction.y * a.direction.x;
  if (det != 0) {
    float u = (d.y * b.direction.x - d.x * b.direction.y) / det;
    float v = (d.y * a.direction.x - d.x * a.direction.y) / det;
    if (u > 0 && v > 0) {
      // front side
      return PVector.add(a.start, PVector.mult(a.direction, u));
    }
    if (u < 0 && v < 0) {
      // backside
      //return PVector.add(a.start, PVector.mult(a.direction, u));
      return null;
    }
  }
  return null;
}
void mouseDragged() {
  float angle = 10.0 * (mouseY-pmouseY) / height;
  if (mouseX < width/2) {
    a.rotate(angle);
  } else {
    b.rotate(angle);
  }
}
void keyPressed() {
    if(key =='s') { save("thumb.png"); println("saved!"); }
}
