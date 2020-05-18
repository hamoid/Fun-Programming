import java.util.Collections;
ArrayList<PVector> points;
void setup() {
  size(800, 800, P2D);
  calcPoints();
}

void draw() {
  translate(width/2, height/2);
  background(#880088);

  beginShape(TRIANGLES);
  for (int i=2; i<points.size(); i++) {
    fill((i*9701) % 256, (i*3301) % 256, (i*4411) % 256);
    vertex(points.get(0).x, points.get(0).y);
    vertex(points.get(i-1).x, points.get(i-1).y);
    vertex(points.get(i).x, points.get(i).y);
  }
  endShape();

  int n = 0;
  for (PVector p : points) {
    fill(0);
    ellipse(p.x, p.y, 20, 20);
    fill(255);
    text(n++, p.x-3, p.y+3);
  }
}
void calcPoints() {
  // Create a list of random angles
  ArrayList<Float> angles = new ArrayList<Float>();
  for (int i=0; i<7; i++) {
    angles.add(random(TAU));
  }  

  // Sort the random angles
  Collections.sort(angles);

  // Convert those angles into 2D points using polar coordinates
  points = new ArrayList<PVector>();
  for (float a : angles) {
    points.add(PVector.fromAngle(a).mult(300));
  }
}
void keyPressed() {
  if (key == ' ') {
    calcPoints();
  }
}
