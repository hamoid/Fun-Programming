// Creative Code Jam - Berlin - 18.10.2014
// By @hamoid

// In this game-exercise, we hear a oral description
// of an animated gif, and try to recreate it based
// only on that description. At the end we are shown the
// original and discover how close we were. 
// Here you can see both side by side:
// https://twitter.com/sableRaph/status/523516372895412225

int steps = 500;
int radius = 200;
int framesTotal = 30 * 9;
float splitWidth = PI/2;
float splitHeight = 25;

void setup() {
  size(500, 500);
  stroke(255);
  strokeWeight(4);
}

void draw() {  
  background(0);
  translate(width/2, height/2);
  float splitCenterAngle = TAU * (frameCount % framesTotal) / (float) framesTotal;
  for (int i=0; i<steps; i++) {
    float currAngle = TAU * i / steps;
    float radiusDelta;
    float angleDiff = abs(diffAngle(splitCenterAngle, currAngle));
    if (angleDiff < splitWidth) {
      float envelope = map(angleDiff, 0, splitWidth, 1, 0);
      radiusDelta = envelope * splitHeight * sin(currAngle*7 + splitCenterAngle);
    } else {
      radiusDelta = 0;
    }
    PVector p1 = getPoint(radius + radiusDelta, currAngle);
    PVector p2 = getPoint(radius - radiusDelta, currAngle);
    
    point(p1.x, p1.y);
    point(p2.x, p2.y);
  }
  save("out.gif");
  exit();
}

PVector getPoint(float r, float a) {
  PVector v = PVector.fromAngle(a);
  v.mult(r);
  return v;
}

float diffAngle(float start, float end) {
  start %= TAU;
  end %= TAU;
  float difference = abs(end - start);
  if (difference > PI) {
    if (end > start) {
      start += TAU;
    } else {
      end += TAU;
    }
  }
  return end - start;
}

