class Thing {
  int id;
  float x0, y0, z0;
  float dx, dy, dz;
  float jitter;

  Thing(int tId) {
    id = tId;
    reset();
  }
  void reset() {
    x0 = random(TWO_PI);
    y0 = random(TWO_PI);
    z0 = random(TWO_PI);
    
    float range = random(0.01, 0.1);
    dx = random(-range, range);
    dy = random(-range, range);
    dz = random(-range, range);
    
    jitter = random(0.001) * random(0.01);
  }
  void drawLine() {
    float x = x0;
    float y = y0;
    float z = z0;

    dx += random(-jitter, jitter);
    dy += random(-jitter, jitter);
    dz += random(-jitter, jitter);

    for (int i=0; i<3000; i++) {    
      pushMatrix();
      rotateX(x);
      rotateY(y);
      rotateZ(z);      
      
      stroke(randomHue,randomSat,255, 20);
      strokeWeight(weight[(frameCount+i)%30]);
      point(200, 0, 0);

      stroke(255, 200);
      strokeWeight(2);
      point(200, 0, 0);
      
      popMatrix();
      x += dx;
      y += dy;
      z += dz;
    }
  }
}

