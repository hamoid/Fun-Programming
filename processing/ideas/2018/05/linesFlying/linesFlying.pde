// NOTE: ported to Idea in 2015-03-Subdivide > Curved.java

ArrayList<PShape> shapes;
int i0, i1;
int dirs[] = {-1, 1};

// ---------------------
void setup() {
  size(900, 900, P2D);
  background(255);
  noFill();
  stroke(0, 80);
  strokeWeight(1);
  rectMode(CENTER);
  frameRate(10);

  shapes = new ArrayList<PShape>();
  shapes.add(createShape(ELLIPSE, width/2, height/2, 800, 800));
}

// ---------------------
void draw() {
  background(255);
  for (PShape s : shapes) {
    shape(s);
  }
  //doit();
}

// ---------------------
void mousePressed() {
  doit(mouseX, mouseY);
}

// ---------------------
int rndNext(int i, int count) {
  return (i + count + dirs[(int) random(dirs.length)]) % count;
}

// ---------------------
// ported from ToxicLibs
PVector lineIntersects (PVector a, PVector b, PVector la, PVector lb) {
  float denom = (lb.y - la.y) * (b.x - a.x) - (lb.x - la.x) * (b.y - a.y);

  float na = (lb.x - la.x) * (a.y - la.y) - (lb.y - la.y) * (a.x - la.x);
  float nb = (b.x - a.x) * (a.y - la.y) - (b.y - a.y) * (a.x - la.x);

  if (denom != 0.0) {
    float ua = na / denom;
    float ub = nb / denom;
    if (ua >= 0.0f && ua <= 1.0 && ub >= 0.0 && ub <= 1.0) {
      PVector r = new PVector();
      r.set(a);
      r.lerp(b, ua);
      return r;
    }
  }
  return null;
}

// ---------------------
boolean intersects(PShape a, PShape b) {
  for (int ia=0; ia<a.getVertexCount()-1; ia++) {
    for (int ib=0; ib<b.getVertexCount()-1; ib++) {
      PVector p0 = a.getVertex(ia);
      PVector p1 = a.getVertex(ia+1);
      PVector p2 = b.getVertex(ib);
      PVector p3 = b.getVertex(ib+1);
      if (lineIntersects(p0, p1, p2, p3) != null) {
        return true;
      }
    }
  }
  return false;
}

// ---------------------
PVector closestIntersection(PVector p0, PVector p1, ArrayList<PShape> shapes) {
  float d = 9999;
  PVector result = null;
  for (PShape s : shapes) {
    for (int i=0; i<s.getVertexCount()-1; i++) {
      PVector a = s.getVertex(i);
      PVector b = s.getVertex(i+1);
      PVector p = lineIntersects(p0, p1, a, b);
      if (p != null) {
        float dd = p0.dist(p);
        if (dd < d) {
          d = dd;
          result = p;
        }
      }
    }
  }
  return result;
}

// ---------------------
void doit(float x, float y) {
  PVector p = new PVector(x, y);
  PVector p0 = p.copy();
  PVector p1 = p.copy();
  PVector r = (PVector.random2D()).mult(1000);
  p0.add(r);
  p1.sub(r);
  PVector a = closestIntersection(p, p0, shapes);
  PVector b = closestIntersection(p, p1, shapes);
  if (a != null && b != null) {
    float d = a.dist(b);
    PVector anext = PVector.add(PVector.mult(PVector.random2D(), d * random(0.1, 0.5)), a);
    PVector bnext = PVector.add(PVector.mult(PVector.random2D(), d * random(0.1, 0.5)), b);

    tryAddBezier(a, anext, bnext, b);
  }
}

// ---------------------
void doit() {

  // choose two random shapes
  PShape shp0 = shapes.get((int)random(shapes.size()));
  PShape shp1 = shapes.get((int)random(shapes.size()));

  // choose a random point and its neighbor on shape 0 
  int count0 = shp0.getVertexCount();
  i0 = (int)random(count0);
  int i0next = rndNext(i0, count0);
  PVector v0 = shp0.getVertex(i0);
  PVector v0next = shp0.getVertex(i0next);

  // choose a random point and its neighbor on shape 1 
  int count1 = shp1.getVertexCount();
  i1 = (int)random(count1);
  int i1next = rndNext(i1, count1);
  PVector v1 = shp1.getVertex(i1);
  PVector v1next = shp1.getVertex(i1next);

  // apparently the ellipse has its center as a vertex !?
  if (PVector.dist(v0, v0next) > 50 || PVector.dist(v1, v1next) >50) {
    return;
  }

  float d = v0.dist(v1);

  // A. tangent points
  //v0next = PVector.add(PVector.mult(PVector.sub(v0next, v0), d * random(0.05, 0.10)), v0);
  //v1next = PVector.add(PVector.mult(PVector.sub(v1next, v1), d * random(0.05, 0.10)), v1);

  // B. random points around source and target
  v0next = PVector.add(PVector.mult(PVector.random2D(), d * random(0.1, 0.5)), v0);
  v1next = PVector.add(PVector.mult(PVector.random2D(), d * random(0.1, 0.5)), v1);

  tryAddBezier(v0, v0next, v1next, v1);
}

void tryAddBezier(PVector v0, PVector v0next, PVector v1next, PVector v1) {
  PShape shp = createShape();
  shp.beginShape();
  for (float t = 0; t<1; t+= 0.04) {
    shp.vertex(
      bezierPoint(v0.x, v0next.x, v1next.x, v1.x, t), 
      bezierPoint(v0.y, v0next.y, v1next.y, v1.y, t)
      );
  }
  shp.vertex(
    bezierPoint(v0.x, v0next.x, v1next.x, v1.x, 1), 
    bezierPoint(v0.y, v0next.y, v1next.y, v1.y, 1)
    );
  shp.endShape();

  shp.setVertex(0, PVector.lerp(shp.getVertex(0), shp.getVertex(1), 0.03));
  int last = shp.getVertexCount() - 1;
  shp.setVertex(last, PVector.lerp(shp.getVertex(last), shp.getVertex(last-1), 0.03));


  boolean good = true;
  for (PShape s : shapes) {
    if (intersects(s, shp)) {
      good = false;
      break;
    }
  }
  if (good) {
    shapes.add(shp);
  }

  shape(shp);
}

// ---------------------
void keyPressed() {
    if(key =='s') { save("thumb.jpg"); println("saved!"); }
}
