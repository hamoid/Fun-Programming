int lastFrame = 60*30;
float a = 0; //random(TAU);
void setup() {
  fullScreen(P3D);
  background(0);
  colorMode(HSB, TAU, 100, 100);
  noStroke();
}

void thebox(float sz) {
  box(sz);
}
void thebox(float sz, float x, float y, float z) {
  pushMatrix();
  translate(x, y, z);
  box(sz/7);
  popMatrix();
}
void draw() {
  if (frameCount < lastFrame) {
    float n = map(frameCount, 0, lastFrame, 0, 1);
    
    if(frameCount % 30 == 0) {
      a += PI;
    }

    directionalLight(a, 90*n, 96*n, cos(a), sin(a), 0);
    a = (a + TAU/3) % TAU;
    directionalLight(a, 45*n, 72*n, cos(a), sin(a), 0);
    a = (a + TAU/3) % TAU;
    directionalLight(a, 22*n, 48*n, cos(a), sin(a), 0);
    a = (a + TAU/3) % TAU;

    translate(width/2, height/2);
    rotateX(10 * n * noise(n * 2));
    rotateY(10 * n * noise(n * 3));
    
    float sz = 1000 * (1-n);
    
    // option 1
    thebox(sz);
    
    // option 2
    //thebox(sz, sz, sz, sz);
    //thebox(sz, sz, sz, -sz);
    //thebox(sz, sz, -sz, sz);
    //thebox(sz, sz, -sz, -sz);
    //thebox(sz, -sz, sz, sz);
    //thebox(sz, -sz, sz, -sz);
    //thebox(sz, -sz, -sz, sz);
    //thebox(sz, -sz, -sz, -sz);
  } else {
    //save("data/" + System.currentTimeMillis() + ".png");
    //exit();
  }
}
