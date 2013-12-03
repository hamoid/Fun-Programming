int FRAMES = 40;
int FRAMEStoSAVE = 0;

void setup() {
  size(500, 500);
  frameRate(30);
  noStroke();
}
void draw() {
  // fade out background
  fill(#21201C, 50);
  rect(0, 0, width, height);
  
  fill(#F0E4D0);
  
  // percent is a number between 0 and 1 that indicates
  // progress in the loop
  float percent = (frameCount%FRAMES) / float(FRAMES-1);
  
  // this loop creates many rectangles with different sizes
  // and rotations
  for (float t=0; t<1; t+=0.07) {
    resetMatrix();
    translate(width/2, height/2);
    
    // There are two ways of having the rectangles accelerate
    // out of sync: by adding an angle offset (used here), or 
    // by having different values subtracted inside atan2().
    float aOffset = TWO_PI * t;
    float a = TWO_PI * percent + aOffset;
    // this is the position on a circle of radius = 1
    float x = cos(a);
    float y = sin(a);
    // calculate the angle between an imaginary point inside
    // the circle (0, -0.7), and the border of the circle.
    float a2 = atan2(y-0, x-.7);
    
    // finally we have the angle for this rectangle.
    // rotate the axes.
    rotate(a2 + TWO_PI*t);
    rect(150*t, 0, 100*t, 10);
  }
  if (FRAMEStoSAVE > 0) {
    saveFrame("image-####.gif");
    println(FRAMEStoSAVE--);
    if (FRAMEStoSAVE < 1) {
      println("Done rendering " + FRAMES + " frames.");
      println("Now:");
      println("gifsicle --delay=3 --loop --optimize=3 *.gif >small.gif");
    }
  }
}
void keyPressed() {
  if (key == 's') {
    FRAMEStoSAVE = FRAMES;
  }
}

