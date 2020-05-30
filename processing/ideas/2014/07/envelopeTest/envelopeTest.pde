Envelope x, y, sz, col;
void setup() {
  size(400, 400);
  background(255);
  noStroke();
  x = new Envelope(new float[] {100, 100, 300, 1000, 250, 300, 150, 1000, 100}, 5);
  y = new Envelope(new float[] {100, 300, 300, 2000, 100}, 5);
  sz = new Envelope(new float[] {20, 500, 30, 1200, 10, 300, 5, 1000, 20}, 5);
  col = new Envelope(new float[] {0, 5000, 255, 7000, 0}, 3);
}
void draw() {
  //background(222);
  x.next();
  y.next();
  sz.next();
  col.next();
  fill(col.currVal);
  ellipse(x.currVal, y.currVal, sz.currVal, sz.currVal);
}

/*
  Defines a timed envelope. points[] are expected as:
 {value, time, value, time, value ...}
 Set repetitions to -1 to loop.
 */
class Envelope {
  float[] points;
  int segmentId;
  int repetitions;
  boolean done = false;
  float startTime, endTime;
  float startVal, currVal, endVal;
  Envelope(float[] points, int repetitions) {
    if (points.length % 2 == 0) {
      println(points);
      println(points.length, "points sent to an Envelope. It should be", 
      points.length-1, "or", points.length+1, "!");
    }
    this.repetitions = repetitions;
    this.points = points;
    segmentId = 0;
    start();
  }
  private void start() {
    startTime = millis();
    endTime = startTime + (int)points[segmentId + 1];
    currVal = startVal = points[segmentId];
    endVal = points[segmentId + 2];
  }
  public void next() {
    if (done) {
      return;
    }
    if (millis() > endTime) {
      segmentId += 2;
      if (segmentId > points.length - 3) {
        if (--repetitions != 0) {
          segmentId = 0;
        } else {
          done = true;
          return;
        }
      } 
      start();
    }
    float t = (millis() - startTime) / (endTime - startTime);

    currVal = easeInOut(t, startVal, endVal-startVal, 1);
  }
}
float easeInOut(float t, float b, float c, float d) {
  if ((t /= d / 2) < 1)
    return c / 2 * t * t + b;
  return -c / 2 * ((--t) * (t - 2) - 1) + b;
}
