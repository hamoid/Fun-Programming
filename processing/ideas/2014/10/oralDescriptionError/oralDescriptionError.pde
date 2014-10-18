int steps = 200;
int radius = 200;
int framesTotal = 30 * 5; 

void setup() {
  size(500, 500);
  stroke(255);
}

void draw() {
  background(0);
  translate(width/2, height/2);
  float high = TAU * (frameCount % framesTotal) / (float) framesTotal;
  for (int i=0; i<steps; i++) {
    float t = TAU * i / steps;
    float currRadius;
    float angleDiff = diffAngle(high, t);
    if (angleDiff < PI/4) {
      float k = map(angleDiff, 0, PI/4, 1, 0);
      currRadius = radius + k * 15 * sin(t*7 + high);
    } else {
      currRadius = radius;
    }
    float x = currRadius * cos(t);
    float y = currRadius * sin(t);
    point(x, y);
  }
}

public static float diffAngle(float start, float end) {
  start %= PApplet.TWO_PI;
  end %= PApplet.TWO_PI;
  float difference = PApplet.abs(end - start);
  if (difference > PApplet.PI) {
    if (end > start) {
      start += PApplet.TWO_PI;
    } else {
      end += PApplet.TWO_PI;
    }
  }
  return end - start;
}

