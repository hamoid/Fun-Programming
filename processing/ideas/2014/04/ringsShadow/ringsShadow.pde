/*
  Shadow attempt.
  Better, create shapes with PShape, rect strip, 
  ondulating up and down 6 times per TAU
 */
void setup() {
  size(400, 400, P3D);
  noStroke();
  colorMode(HSB);
  rectMode(CENTER);
  //ortho(-width/2, width/2, -height/2, height/2, 1, 400);
  ortho();
  background(0);
}
void draw() {
  ring(width/2-50, height/2-40, 0, 100, 50, #FFFF00, false);
  ring(width/2+50, height/2-40, 1, 100, 50, #FF00FF, false);
  ring(width/2, height/2+45, 0.5, 100, 50, #00FFFF, true);
  noLoop();
}
void ring(float x, float y, float z, float radius, float sz, int c, boolean zosc) {
  int steps = (int)radius/2;
  for (int i=0; i<steps; i++) {
    pushMatrix();
    if (zosc) {
      // z oscillation. Move forward and back to achieve trick.
      float nz = (i/int(steps/5.5)) % 2 < 1 ? 9 : -9;
      translate(x, y, nz);
      rotateZ((i+11)*TWO_PI/steps);
    }
    else {
      translate(x, y, z);
      rotateZ(i*TWO_PI/steps);
    }
    float h = steps*0.33;
    int n=0;
    for(float t=1; t>0; t-=0.1, n++) {
      stroke(0, t*t*20+1);
      line(radius+n+sz/2, -h, radius+n+sz/2, h);
      line(radius-n-sz/2, -h, radius-n-sz/2, h);
    }
    fill(c);
    noStroke();
    rect(radius, 0, sz, h);
    popMatrix();
  }
}
