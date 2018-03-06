color bg;
Tracer t;
boolean waitForClick;
void setup() {
  size(900, 900);
  colorMode(HSB);
  bg = color(15);
  background(bg);
  noiseSeed(System.currentTimeMillis() % 1000);
  t = new Tracer();
}
void draw() {
  for (int i=0; i<10; i++) {
    t.draw();
  }
}

class Tracer {
  float x, y, a, step, radius, turnDir, softTurn, fat, tolerance;
  int baseColor;
  boolean intelligentTurn;
  Tracer() {
    respawn();
  }
  void draw() {
    if(waitForClick) {
      return;
    }
    boolean needRespawn = (!frontIsClear() || !insideTheCanvas());
    
    step = 3;
    float nx = x + step * cos(a);
    float ny = y + step * sin(a);
    
    // line style A
    /*
    stroke(255);
    strokeWeight(1);
    for(float i=0; i<1; i+=0.05) {
      stroke(baseColor, map((1-i)*(1-i), 1, 0, 40, 5));
      float dx = i * fat * cos(a+HALF_PI);
      float dy = i * fat * sin(a+HALF_PI);
      line(x+dx, y+dy, nx+dx, ny+dy);
    }
    */

    // line style B
    /*
    strokeWeight(step*noise(x*0.01, y*0.01)+abs(randomGaussian()*0.4));
    stroke(255, 50);    
    for(int i=0; i<5; i++) {
      line(x+ randomGaussian(), y+ randomGaussian(), nx+ randomGaussian(), ny+ randomGaussian());
    }
    */

    // line style C
    //stroke(0, 256 * noise(frameCount * 0.1), 250, 70);
    stroke((noise(0) * 2000 + a) % 256, 255, 250, 70);
    strokeWeight(1);  
    for(int i=0; i<5; i++) {
      line(x+ randomGaussian(), y+ randomGaussian(), nx+ randomGaussian(), ny+ randomGaussian());
    }
    
   
    x = nx;
    y = ny;
    
    if(needRespawn) {
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
    baseColor = random(100) < 50 ? 0 : (random(100) < 2 ? 0xFFFF0000 : 0xFFFAF8F2);
    //waitForClick = true;
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
    
    float xL = x + 2 * cos(a + HALF_PI);
    float yL = y + 2 * sin(a + HALF_PI);
    float xR = x + 2 * cos(a - HALF_PI);
    float yR = y + 2 * sin(a - HALF_PI);
    
    for (hitDist=step; hitDist<radius; hitDist++) {      
      float txL = xL + hitDist * cos(a);
      float tyL = yL + hitDist * sin(a);
      color cL = get((int)txL, (int)tyL);
      float bri = brightness(cL);
      if (bri < 15 || bri > 100) {
        hit = true;
        frontClear = hitDist > step;
        if(intelligentTurn) {
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
        if(intelligentTurn) {
          turnDir = 1;
        }
        break;
      }
    }
    a += (hit ? 1 : softTurn) * turnDir * step * HALF_PI / hitDist;
    return frontClear;
  }
}
void mousePressed() {
  t.respawn();
  t.x = mouseX;
  t.y = mouseY;
  waitForClick = false;
}
void keyPressed() {
  if (key=='s') {
    save(int(random(999999)) + ".png");
  }
  if(key=='r') {
    background(bg);
    noiseSeed(System.currentTimeMillis() % 1000);
  }
  if(key == ' ') {
    waitForClick = true;
  }
}
