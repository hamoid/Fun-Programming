class Polygon {
  int sides, offset, radius0, radius1;
  float rot0, rot1;
  Polygon(int sides, int radius0, int radius1, float rot0, float rot1) {
    this.sides = sides;
    this.offset = offset;
    this.radius0 = radius0;
    this.radius1 = radius1;
    this.rot0 = rot0;
    this.rot1 = rot1;
  }
  @Override String toString() {
    return sides + ", " + offset + ", " + radius0 + ", " + radius1 + ", " +
      rot0 + ", " + rot1;  
  }
}
