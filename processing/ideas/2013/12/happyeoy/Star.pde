class Star {
  PVector p0, p1, pa, pb;
  color c;
  Star() {
    c = color(#00FF00);
    calcEnd();
    calcStart();
    calcWaypoints();
  }
  // find a random point that is not black
  private void calcEnd() {
    color black = color(0);
    while (true) {
      p1 = new PVector(random(width), random(height));
      if (get((int)p1.x, (int)p1.y) != black) {
        break;
      }
    }
  }
  // find a point around the end point at a random distance
  private void calcStart() {
    p0 = PVector.fromAngle(random(TWO_PI));
    float d = random(100);
    p0.mult(d);
    p0.add(p1);
  }
  // calculate two way points which are near
  // the start point and the end point
  private void calcWaypoints() {
    PVector r;
   
    r = PVector.random2D();
    r.mult(20);
    pa = PVector.add(p0, r);
    
    r = PVector.random2D();
    r.mult(20);
    pb = PVector.add(p1, r);
  }
  void draw(float p) {
    // when to stop moving and begin fading out. 0.8 = 80%, 
    // which means the final 20% of the animation.
    float cut = 0.8;
    PVector curr;
    // if we are near the end, don't move, just fade out
    if (p > cut) {
      curr = p1;
      fill(c, map(p, cut, 1, 128, 0));
    } 
    else {
      // map 0 .. 0.8 to 0 .. 1
      p = p / cut;
      // inverse
      p = 1 - p;
      // spend more time at the beginning
      p = pow(p, 3);
      // inverse, so spend more time at the end
      p = 1 - p;
      // curved line (find out where we are)
      curr = new PVector(
        bezierPoint(p0.x, pa.x, pb.x, p1.x, p),
        bezierPoint(p0.y, pa.y, pb.y, p1.y, p) 
      );
      // straight line
      //curr = PVector.lerp(p0, p1, p);
      // fade in
      fill(c, pow(p, 2)*128);
    }
    float sz = 2;
    // draw particle
    ellipse(curr.x, curr.y, sz, sz);
    
    // draw glow
    fill(c, 8 * p);
    ellipse(curr.x, curr.y, 10, 10);
  }
}

