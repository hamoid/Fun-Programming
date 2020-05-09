import java.util.List;

// see https://stackoverflow.com/questions/1073336/circle-line-segment-collision-detection-algorithm

PVector p0 = new PVector(100.0, 100.0);
PVector p1 = new PVector(400.0, 400.0);
float circleRadius = 90.0;

void settings() {
  size(640, 480);
}

void draw() {
  background(255);
  fill(#FFAA00, 100);
  stroke(0, 100);
  strokeWeight(2);
  
  PVector circleCenter = new PVector(mouseX, mouseY);
  line(p0.x, p0.y, p1.x, p1.y);
  circle(circleCenter.x, circleCenter.y, circleRadius * 2);

  List<PVector> intersections = intersections(p0, p1, circleCenter, circleRadius);
  for(PVector i : intersections) {
    circle(i.x, i.y, 10);
  }
}

List<PVector> intersections(PVector start, PVector end, PVector circleCenter, float radius) {
  PVector d = PVector.sub(end, start);
  PVector f = PVector.sub(start, circleCenter);
  
  List<PVector> result = new ArrayList<PVector>();

  float a = d.dot(d);
  float b = 2 * f.dot( d );
  float c = f.dot(f) - radius * radius;

  float discriminant = b * b - 4 * a * c;
  if ( discriminant < 0 ) {
    return result;
  } 

  discriminant = sqrt(discriminant);

  float t1 = (-b - discriminant) / (2 * a);
  float t2 = (-b + discriminant) / (2 * a);

  if (t1 >= 0 && t1 <= 1) {
    result.add(PVector.lerp(start, end, t1));
  }

  if (t2 >= 0 && t2 <= 1) {
    result.add(PVector.lerp(start, end, t2));
  }    

  return result;
}
