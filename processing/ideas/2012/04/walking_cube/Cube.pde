class Cube {
  float csize;
  float frames;
  float z;
  int c = 0;
  int dir = 1;
  boolean pause = true;
  color col;

  Cube(float s, float f, float zz, color co) {
    csize = s;
    frames = f;
    z = zz;
    col = co;    
  }

  void draw() {
    if (pause) {
      if (random(100) > 98) {
        pause = false;
      }
    } 
    else {
      c += dir;
      if (c % frames == 0) {
        if (c > 180) {
          dir = -1;
        }
        if (c < 20) {
          dir = 1;
        }
        if (random(10) > 3) {
          pause = true;
        }
      }
    }

    float a = (c % frames) / frames;
    float h = csize*sin(PI/4 + a * PI / 2);
    float x = csize*cos(PI/4 + a * PI / 2); 
    int offset = int(c / frames);
    float sz = sqrt(0.5)*2*csize;
    
    pushMatrix();
    translate(sz*offset-x, height/2 + 100 - h, z);
    rotateZ(c/frames * PI / 2);
    fill(col);
    box(sz);
    popMatrix();
  }
}

