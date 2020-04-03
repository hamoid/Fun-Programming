class Tracer {
  float x, y, a, step, radius, turnDir, softTurn, fat, tolerance;
  boolean intelligentTurn;

  // TODO: two modes: free curving, avoid collision

  Tracer() {
    respawn();
  }
  void draw() {
    boolean needRespawn = (!frontIsClear() || !insideTheCanvas());

    step = 3;
    float nx = x + step * cos(a);
    float ny = y + step * sin(a);

    stroke(255);
    strokeWeight(5);  
    for (int i=0; i<5; i++) {
      line(x, y, nx, ny);
    }

    x = nx;
    y = ny;

    if (needRespawn) {
      respawn();
    }
  }
  void respawn() {
    intelligentTurn = false; //random(100) < 50;
    turnDir = random(100) < 50 ? -1 : 1;
    x = random(width);
    y = random(height);
    a = 0.001 * frameCount % TAU;
    radius = random(5, 30);
    softTurn = random(0.02);
    fat = max(1, 50 + randomGaussian() * 50);
    tolerance = random(50, 200);
  }
  boolean insideTheCanvas() {
    return x<width && x>0 && y<height && y>0;
  }
  void testCollision() {
    color c = get((int)x, (int)y);
    if (c != bg) {
      respawn();
    }
  }
  boolean frontIsClear() {
    float hitDist;
    boolean hit = false, frontClear = true;
    float sep = 6; 

    float xL = x + sep * cos(a + HALF_PI);
    float yL = y + sep * sin(a + HALF_PI);
    float xR = x + sep * cos(a - HALF_PI);
    float yR = y + sep * sin(a - HALF_PI);

    for (hitDist=step; hitDist<radius; hitDist++) {      
      float txL = xL + hitDist * cos(a);
      float tyL = yL + hitDist * sin(a);
      color cL = get((int)txL, (int)tyL);
      float bri = brightness(cL);
      if (bri < 15 || bri > tolerance) {
        hit = true;
        frontClear = hitDist > step;
        if (intelligentTurn) {
          turnDir = -1;
        }
        break;
      }
      float txR = xR + hitDist * cos(a);
      float tyR = yR + hitDist * sin(a);
      color cR = get((int)txR, (int)tyR);
      bri = brightness(cR);
      if (bri < 15 || bri > tolerance) {
        hit = true;
        frontClear = hitDist > step;
        if (intelligentTurn) {
          turnDir = 1;
        }
        break;
      }
    }
    a += (hit ? 1 : softTurn) * turnDir * step * HALF_PI / hitDist;
    return frontClear;
  }
}
