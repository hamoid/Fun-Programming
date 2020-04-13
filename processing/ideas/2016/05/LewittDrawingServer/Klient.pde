class Klient {
  private float x, y;
  private float tx, ty;
  private float px, py;
  private int age;
  private int id;
  private int click;
  
  Klient(int id, int x, int y) {
    this.tx = x;
    this.ty = y;
    this.x = x;
    this.y = y;
    this.id = id;
  }
  void update(int x, int y) {
    this.px = this.x;
    this.py = this.y;
    this.tx = x;
    this.ty = y;
    this.age = 0;
  }  
  void draw(PGraphics pg) {
    x = lerp(x, tx, 0.1);
    y = lerp(y, ty, 0.1);
    PVector v = new PVector(x - px, y - py);
    v.normalize();
    v.mult(30);
    pg.beginDraw();
    pg.stroke(isClicked() ? 255 : #FF8800);
    pg.line(x, y, x+v.x, y+v.y);
    pg.endDraw();
    age++;
  }
  boolean isOld() {
    return age > 100;
  }
  boolean isClicked() {
    return click == 1;
  }
  void setClick() {
    click = 1;
  }
  void unClick() {
    click = 0;
  }
}