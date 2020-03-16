PanZoomCanvas canvas[];
PanZoomCanvas target;

void setup() {
  size(1200, 800, P3D);
  surface.setTitle("sketch_panzoom");
  canvas = new PanZoomCanvas[6];
  for (int i=0; i<canvas.length; i++) {
    canvas[i] = new PanZoomCanvas(1500, 1500, P3D);
    canvas[i].setViewport((i%3)*400, (i/3)*400, 400, 400);
  }
}
void draw() {
  // This `if` should be inside setup but doesn't work in my system. See:
  // https://discourse.processing.org/t/pgraphics-behaving-unexpectedly/18710
  if (frameCount == 2) {
    for (PanZoomCanvas c : canvas) {
      PGraphics pg = c.canvas;
      pg.beginDraw();
      pg.clear();
      pg.background(random(20, 100));
      pg.blendMode(ADD);
      pg.colorMode(HSB);
      pg.noStroke();
      for (int j=0; j<50; j++) {
        float sz = 50 * (int)(1+random(4));
        pg.fill(
          random((j*1337)%256), 
          random((j*2199)%256), 
          random((j*3821+50)%256));
        pg.ellipse(random(pg.width), random(pg.height), sz, sz);
      }
      pg.endDraw();
    }
  }

  // NOTE: it's not fast enough to draw on 6 PGraphics on every
  // frame (fps goes down to 13~30). Drawing only on one is fine,
  // fps stays at 60.
  PGraphics pg = canvas[frameCount % canvas.length].canvas;
  pg.beginDraw();
  pg.stroke(random(10));
  pg.blendMode(ADD);
  pg.line(0, random(pg.height), pg.width, random(pg.height));
  pg.blendMode(SUBTRACT);
  pg.line(random(pg.width), 0, random(pg.width), pg.height);
  pg.endDraw();

  for (PanZoomCanvas c : canvas) {
    c.draw();
  }

  text("Use the mouse wheel to zoom, drag mouse for panning", 40, 40);

  if (frameCount % 60 == 50) {
    println(frameRate);
  }
}
void mousePressed() {
  for (PanZoomCanvas c : canvas) {
    if (c.inside(mouseX, mouseY)) {
      target = c;
      break;
    }
  }
}
void mouseMoved() {
  target = null;
}
void mouseWheel(MouseEvent event) {
  if (target == null) {
    mousePressed();
  }
  if (target != null) {
    target.wheel(1.0 + 0.1 * event.getCount());
  }
}
void mouseDragged() {
  target.drag(mouseX - pmouseX, mouseY - pmouseY);
}
