class Point {
  PVector pos;
  PVector norm;
  float w;
  Point(float x, float y, float z, float w) {
    pos = new PVector(x, y, z);
    norm = new PVector();
    this.w = w;
  }
  void resizeNormal() {
    norm.setMag(w);
  }
}

class ThickLine {
  boolean isLoop = false;
  ArrayList<Point> points = new ArrayList<Point>();

  PShape shp;
  PShape spine;
  int fillColor;

  ThickLine() {
    fillColor = lerpColor(#D0F0D4, #27404D, random(1));
  }

  void addPoint(float x, float y) {
    points.add(new Point(x, y, 0, 10));
  }

  void addPoint(float x, float y, float w) {
    points.add(new Point(x, y, 0, w));
  }

  void addPoint(float x, float y, float z, float w) {
    points.add(new Point(x, y, z, w));
  }

  void setLoop(boolean loop) {
    isLoop = loop;
  }

  void recalculate() {
    int pointsSize = points.size();
    PVector sub = new PVector();

    // Calculate normals
    if (!isLoop) {
      for (int i=0; i<pointsSize-1; i++) {
        Point p = points.get(i);
        PVector.sub(p.pos, points.get(i+1).pos, sub); 
        p.norm.set(-sub.y, sub.x);
      }
      for (int i=1; i<pointsSize; i++) {
        Point p = points.get(i % pointsSize);
        PVector.sub(p.pos, points.get(i-1).pos, sub); 
        p.norm.add(sub.y, -sub.x);
      }
    } else {
      for (int i=0; i<pointsSize; i++) {
        Point p = points.get(i);
        PVector.sub(p.pos, points.get((i+1) % pointsSize).pos, sub); 
        p.norm.set(-sub.y, sub.x);
        PVector.sub(p.pos, points.get((i-1+pointsSize) % pointsSize).pos, sub); 
        p.norm.add(sub.y, -sub.x);
      }
    }

    // Resize normals
    for (Point p : points) {
      p.resizeNormal();
    }

    shp = createShape();
    shp.beginShape(PConstants.QUAD_STRIP);
    for (Point p : points) {
      shp.vertex(p.pos.x + p.norm.x, p.pos.y + p.norm.y, p.pos.z);
      shp.vertex(p.pos.x - p.norm.x, p.pos.y - p.norm.y, p.pos.z);
    }    
    if (isLoop) {
      Point p = points.get(0);
      shp.vertex(p.pos.x + p.norm.x, p.pos.y + p.norm.y, p.pos.z);
      shp.vertex(p.pos.x - p.norm.x, p.pos.y - p.norm.y, p.pos.z);
    }
    shp.endShape();

    spine = createShape();
    spine.beginShape();
    for (Point p : points) {
      spine.vertex(p.pos.x, p.pos.y, p.pos.z);
    }    
    if (isLoop) {
      spine.endShape(CLOSE);
    } else {
      spine.endShape();
    }
  }

  void drawThick() {
    shp.setFill(fillColor);
    shp.setStroke(false);
    shape(shp);
  }

  void drawThickVertices() {
    stroke(lerpColor(fillColor, #FFFFFF, 0.5));
    strokeWeight(4);
    for (Point p : points) {
      point(p.pos.x + p.norm.x, p.pos.y + p.norm.y, p.pos.z);
      point(p.pos.x - p.norm.x, p.pos.y - p.norm.y, p.pos.z);
    }
  }

  void drawSpine() {
    spine.setFill(false);
    spine.setStroke(lerpColor(fillColor, #000000, 0.2));
    shape(spine);
  }

  void drawSpineVertices() {
    stroke(lerpColor(fillColor, #FFFFFF, 0.4));
    strokeWeight(4);
    for (Point p : points) {
      point(p.pos.x, p.pos.y, p.pos.z);
    }
  }

  void calculateObj(StringBuilder v, StringBuilder f) {
    v.setLength(0);
    f.setLength(0);
    for (int i=0; i<shp.getVertexCount(); i+=3) {
      PVector ve = shp.getVertex(i);
      v.append("v " + ve.x + " " + ve.y + " " + ve.z + "\n");
      f.append("f " + (i+1) + " ");
      ve = shp.getVertex(i+1);
      v.append("v " + ve.x + " " + ve.y + " " + ve.z + "\n");
      f.append((i+2) + " ");
      ve = shp.getVertex(i+2);
      v.append("v " + ve.x + " " + ve.y + " " + ve.z + "\n");
      f.append((i+3) + "\n");
    }
  }
}
