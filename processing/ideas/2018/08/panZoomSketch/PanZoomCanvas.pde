// Part of aBeLibs
class PanZoomCanvas {
  float zoom = 1.0;
  float zoomCurr = 1.0;
  PVector offset = new PVector();
  PVector offsetCurr = new PVector();

  int x, y, w, h;

  public PGraphics canvas;

  PanZoomCanvas(int w, int h, String mode) {
    canvas = createGraphics(w, h, mode);
  }
  public void setViewport(int x, int y, int w, int h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
  private void constrainView() {
    offset.x = (int)constrain(offset.x, 0, canvas.width * (1-zoom));
    offset.y = (int)constrain(offset.y, 0, canvas.height * (1-zoom));
  }
  public void draw() {
    zoomCurr = lerp(zoomCurr, zoom, 0.2);
    offsetCurr.lerp(offset, 0.2);
    textureWrap(REPEAT);
    beginShape();
    texture(canvas);
    int x1 = (int)offsetCurr.x;
    int y1 = (int)offsetCurr.y;
    int sz = max(canvas.width, canvas.height);
    int x2 = (int)(offsetCurr.x + sz * zoomCurr);
    int y2 = (int)(offsetCurr.y + sz * zoomCurr);
    vertex(x, y, x1, y1);
    vertex(x + w, y, x2, y1);
    vertex(x + w, y + h, x2, y2);
    vertex(x, y + h, x1, y2);
    endShape();
  }
  public boolean inside(int mx, int my) {
    return mx > x && my > y && mx < x + w && my < y + h;
  }
  public void drag(int dx, int dy) {
    offset.x -= dx;
    offset.y -= dy;
    constrainView();
  }
  public void wheel(float z) {
    float newZoom = zoom * z;
    float k = min(
      w / (float)canvas.width, 
      h / (float)canvas.height);
    newZoom = constrain(newZoom, k, 1.0);
    float zoomChange = newZoom - zoom;
    offset.x -= (mouseX - x) * zoomChange / k;
    offset.y -= (mouseY - y) * zoomChange / k;
    zoom = newZoom;
    constrainView();
  }
}
