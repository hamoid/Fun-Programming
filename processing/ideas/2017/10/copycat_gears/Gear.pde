class Gear {
  PVector pos;
  PShape s;
  float radius;
  float interlocking = 30;
  float interlockingLength;
  float rotationAngle = 0;
  float cw = 1;

  Gear(int teeth, boolean cw, boolean shift) {
    s = createShape();
    s.beginShape();
    s.fill(#B5DE5A);
    s.noStroke();
    PVector p;
    radius = teeth * 10;
    interlockingLength = TWO_PI * (radius);
    float aDelta = TWO_PI/(4*teeth);
    for (int i=0; i<teeth; i++) {
      float a = i*TWO_PI/teeth + (cw ? aDelta : 0) + (shift ? aDelta*2 : 0);

      p = PVector.fromAngle(a+aDelta*0);
      p.mult(radius);
      s.vertex(p.x, p.y);

      p = PVector.fromAngle(a+aDelta*1);
      p.mult(radius);
      s.vertex(p.x, p.y);

      p = PVector.fromAngle(a+aDelta*2);
      p.mult(radius-interlocking);
      s.vertex(p.x, p.y);

      p = PVector.fromAngle(a+aDelta*3);
      p.mult(radius-interlocking);
      s.vertex(p.x, p.y);
    }
    s.endShape(CLOSE);
    if (cw) {
      this.cw = -1;
    }
  }
  void setPos(float x, float y) {
    pos = new PVector(x, y);
  }
  void rot(float len) {
    // convert a rotation distance into an angle
    rotationAngle += cw * TWO_PI * len/interlockingLength;
  }
  void draw() {
    pushMatrix();
    translate(pos.x, pos.y);
    //println(rotationAngle, interlockingLength);
    rotate(rotationAngle);
    shape(s);
    popMatrix();
  }
  public float getRadius() {
    return radius - interlocking/2;
  }
  public float getRotation() {
    return rotationAngle;
  }
}