import peasy.*;
PeasyCam cam;
boolean b[] = new boolean[3];
PShape shp1, shp2;

void setup() {
  size(800, 600, P3D);
  cam = new PeasyCam(this, 400);
  hint(DISABLE_DEPTH_TEST);
  hint(DISABLE_DEPTH_SORT);
  hint(DISABLE_DEPTH_MASK);
  shp1 = createShape(SPHERE, 90);
  shp1.setStroke(false);
  shp1.setFill(color(255, 40, 20, 100));
  shp2 = createShape(BOX, 180);
  shp2.setStroke(false);
  shp2.setFill(color(255, 40, 20, 100));
}

void draw() {
  background(255);

  cam.beginHUD();
  fill(0);
  text("DEPTH_TEST " + b[0], 20, 20);
  text("DEPTH_SORT " + b[1], 20, 40);
  text("DEPTH_MASK " + b[2], 20, 60);
  text("<- use the mouse to toggle settings", 200, 40);
  cam.endHUD();
  
  for (int x = -200; x<=200; x+=200) {
    for (int y = -200; y<=200; y+=200) {
      pushMatrix();
      translate(x, 0, y);
      shape((x+y)/200 % 2 == 0 ? shp1 : shp2);
      popMatrix();
    }
  }
}
void mousePressed() {
  int id = mouseY / 20;
  if (id < b.length) {
    b[id] ^= true; // same as b[id] = !b[id]
  }
  hint(b[0] ? ENABLE_DEPTH_TEST : DISABLE_DEPTH_TEST);
  hint(b[1] ? ENABLE_DEPTH_SORT : DISABLE_DEPTH_SORT);
  hint(b[2] ? ENABLE_DEPTH_MASK : DISABLE_DEPTH_MASK);
}
