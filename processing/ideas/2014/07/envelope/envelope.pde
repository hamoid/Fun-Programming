Envelope sz;
void setup() {
  size(400, 400, P2D);
  sz = new Envelope(new float[] { 0, 100, 1, 200, 0, 100, 0.5, 200, 0, 1000, 0 }, -1);
  fill(#74F5B3);
  noStroke();
}
void draw() {
  background(#C10C67);
  if(!sz.done) {
    sz.next();
    ellipse(width/2, height/2, sz.currVal * 255, sz.currVal * 255);
  }
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
    float pc = (millis() - startTime) / (endTime - startTime);
    currVal = lerp(startVal, endVal, pc);
  }
}
