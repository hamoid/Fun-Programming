void setup() {
  size(500, 500, P2D);
  strokeWeight(1);
}
void draw() {
  background(0);
  int d = 0;
  for (int y=-100; y<height+50; y+=15) {
    for (int x=0; x<width; x++) {
      stroke(d % 2 == 0 ? #D8D4CE : #F9F7F1);
      int yy = y + frameCount % 30;
      float they = yy + 20 * (sin((x+yy*4)/100.0) + sin((x-yy)/77.7) + sin(x/45.7) - sin(yy*x/5866.6));
      line(x, they, x, they + 70);
    }
    d++;
  }
  if(frameCount < 31) {
    //saveFrame("/tmp/a/a####.tif");
    println(frameCount);
  }
}