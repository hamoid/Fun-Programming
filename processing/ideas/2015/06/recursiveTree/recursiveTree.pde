int framesTotal = 50;
int framesToSave = 0;
int seed = 0;

void branch(float x, float y, float angle, float wi) {
  float t = (frameCount % framesTotal) / (float) framesTotal;
  // We can adjust the length of the segments 
  // in relation to the width to make the tree thinner
  // or thicker.
  float len = wi * 1.3;
  float theAngle = angle + 0.1 * sin(t * TWO_PI + x * 0.02);

  pushMatrix();
  translate(x, y);
  rotate(theAngle);
  stroke(lerpColor(#BF4D28, #655643, wi/30));
  strokeWeight(wi);
  // Notice we draw the line on the x axis. 
  // But we have rotated the axes, so x points up!
  line(0, 0, len, 0);
  popMatrix();

  // If the branch is not too thin, keep going
  if (wi > 1) {
    // Use polar coordinates to move away from x and y,
    // in direction "angle" and "len" pixels away.
    float newx = x + len * cos(theAngle);
    float newy = y + len * sin(theAngle);

    // The new angle is very similar to the previous one
    float newangle = theAngle * random(0.99, 1.01);

    // The new width is slightly thinner.
    float newwi = wi * random(0.88, 0.98);

    // Draw the branch (continuation)
    branch(newx, newy, newangle, newwi);

    // In 25% of the cases, create a second branch.
    // Otherwise the whole tree would be just one branch.
    if (random(100) < 25) {
      // The new angle for the extra branch is more random
      // than the continuation of a branch.
      float newangle2 = angle * random(0.8, 1.2);

      // Draw the new branch
      branch(newx, newy, newangle2, newwi * 0.9);
    }
  }
}

void setup() {
  size(540, 540);
}

void draw() {
  randomSeed(seed);
  background(#80BCA3);
  // radians(270) = pointing up to the sky
  branch(width/2, height, radians(270), 30);
  if(framesToSave > 0) {
    saveFrame("/tmp/a/dancingTree####.gif");
    framesToSave--;
    println(framesToSave);
  }
}
void keyPressed() {
  if (key == ' ') {
    seed = frameCount;
  }
  if(key == 's') {
    framesToSave = framesTotal;
  }
}

