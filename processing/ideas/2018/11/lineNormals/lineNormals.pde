ArrayList<PVector> points;
ArrayList<PVector> normals;

void setup() {
  size(400, 400);
  background(255);

  // 1. Define polyline points
  points = new ArrayList<PVector>();
  points.add(new PVector(61, 183));
  points.add(new PVector(108, 113));
  points.add(new PVector(193, 118));
  points.add(new PVector(256, 158));
  points.add(new PVector(248, 239));
  points.add(new PVector(258, 310));
  points.add(new PVector(328, 353));
  points.add(new PVector(377, 341));

  // 2. calculations

  // Ensure normals has the same size as points
  normals = new ArrayList<PVector>();
  while (normals.size() < points.size()) {
    normals.add(new PVector());
  }

  // Calculate normals
  for (int i=0; i<points.size()-1; i++) {
    PVector sub = PVector.sub(points.get(i), points.get(i+1)); 
    normals.get(i).set(-sub.y, sub.x);
  }
  for (int i=1; i<points.size(); i++) {
    PVector sub = PVector.sub(points.get(i), points.get(i-1)); 
    normals.get(i).add(sub.y, -sub.x);
  }
  
  // Resize normals
  for(PVector n : normals) {
    n.normalize().mult(random(10, 30));
  }  
  
  // 3. Use the calculated normals
  // to draw in different ways
  
  // draw calculated thick line
  noStroke();
  fill(#FFCC00);
  beginShape(PConstants.QUAD_STRIP);
  for (int i=0; i<points.size(); i++) {
    PVector p = points.get(i);
    PVector n = normals.get(i);   
    vertex(p.x + n.x, p.y + n.y);
    vertex(p.x - n.x, p.y - n.y);
  }
  endShape();

  // draw the spine
  stroke(#552200);
  noFill();
  beginShape();
  for (PVector p : points) {
    vertex(p.x, p.y);
  }
  endShape();

  // draw spine vertices
  stroke(#552200);
  strokeWeight(2);
  fill(255);
  for (PVector p : points) {
    ellipse(p.x, p.y, 6, 6);
  }
  
  // draw contour points
  noStroke();
  fill(#883300);
  for (int i=0; i<points.size(); i++) {
    PVector p = points.get(i);
    PVector n = normals.get(i);   
    ellipse(p.x + n.x, p.y + n.y, 3, 3);
    ellipse(p.x - n.x, p.y - n.y, 3, 3);
  }
}
void draw() {
}
void keyPressed() {
  if(key == 's') {
    save("thumb.png");
  }
}
