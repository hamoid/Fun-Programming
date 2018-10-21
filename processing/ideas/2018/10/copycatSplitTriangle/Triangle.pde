public class Triangle {
  private PShape tri;
  private PVector position = new PVector();
  private float angle;
  private float radius;
  public Triangle(float radius, float x, float y) {
    position.set(x, y);
    this.radius = radius;

    tri = createShape();
    tri.beginShape();
    for (float a=HALF_PI; a<TAU; a+=TAU/3) {
      tri.vertex(radius*cos(a), radius*sin(a));
    }
    tri.endShape(CLOSE);
  }
  public void draw() {
    fill(255);
    pushMatrix();
    translate(position.x, position.y);
    rotate(angle);
    shape(tri);
    popMatrix();
  }
  public void setOffset(float x, float y) {
    tri.translate(x, y);
  }
  public void setAngle(float a) {
    angle = a;
  }
  public float getRadius() {
    return radius;
  }
  public float getSide() {
    return 3 * radius / sqrt(3);
  }
}
