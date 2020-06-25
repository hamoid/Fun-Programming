float x0, y0, r0, x1, y1, r1;
float[][] tangents;

void setup() {
  size(680, 382);
  x1 = width/2;
  y1 = height/2;
  r1 = 100;
  r0 = 50;
  noFill();
  tangents = new float[4][4];
}

void draw() {
  background(255);
  x0 = mouseX;
  y0 = mouseY;
  ellipse(x0, y0, r0*2, r0*2);
  ellipse(x1, y1, r1*2, r1*2);
  int tangentsCount = getTangents(x0, y0, r0, x1, y1, r1, tangents);
  for(int i=0; i<tangentsCount; i++) {
    float[] line = tangents[i];
    line(line[0], line[1], line[2], line[3]);
    ellipse(line[0], line[1], 5, 5);
    ellipse(line[2], line[3], 5, 5);
  }
}

int getTangents(float x1, float y1, float r1, float x2, float y2, float r2, float[][] res) {
  float d_sq = (x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2);
  if (d_sq <= (r1-r2)*(r1-r2)) return 0;

  float d = sqrt(d_sq);
  float vx = (x2 - x1) / d;
  float vy = (y2 - y1) / d;

  int i = 0;

  // Let A, B be the centers, and C, D be points at which the tangent
  // touches first and second circle, and n be the normal vector to it.
  //
  // We have the system:
  //   n * n = 1          (n is a unit vector)          
  //   C = A + r1 * n
  //   D = B +/- r2 * n
  //   n * CD = 0         (common orthogonality)
  //
  // n * CD = n * (AB +/- r2*n - r1*n) = AB*n - (r1 -/+ r2) = 0,  <=>
  // AB * n = (r1 -/+ r2), <=>
  // v * n = (r1 -/+ r2) / d,  where v = AB/|AB| = AB/d
  // This is a linear equation in unknown vector n.

  for (int sign1 = +1; sign1 >= -1; sign1 -= 2) {
    float c = (r1 - sign1 * r2) / d;

    // Now we're just intersecting a line with a circle: v*n=c, n*n=1

    if (c*c > 1.0) continue;
    float h = sqrt(max(0.0, 1.0 - c*c));

    for (int sign2 = +1; sign2 >= -1; sign2 -= 2) {
      float nx = vx * c - sign2 * h * vy;
      float ny = vy * c + sign2 * h * vx;

      float[] a = res[i++];
      a[0] = x1 + r1 * nx;
      a[1] = y1 + r1 * ny;
      a[2] = x2 + sign1 * r2 * nx;
      a[3] = y2 + sign1 * r2 * ny;
    }
  }

  return i;
}
