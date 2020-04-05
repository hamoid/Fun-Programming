void setup() {
  size(800, 800, P2D);
  colorMode(HSB, 1.0);
  blendMode(SUBTRACT);
}

// A function available in GLSL, ported to java
float smoothstep(float edge0, float edge1, float x) {
  x = constrain((x - edge0) / (edge1 - edge0), 0.0, 1.0); 
  return x * x * (3 - 2 * x);
}

float getScale(float currAngle, float highAngle, float overlap) {
  highAngle = ((currAngle + highAngle) % TAU) - PI;
  return smoothstep(-overlap, 0, highAngle) - smoothstep(0, overlap, highAngle);
}

void draw() {
  background(0.1, 0.1, 1.0);
  translate(width/2, height/2);

  // create 7 shapes
  for (float high=0; high<TAU-0.1; high+=TAU/7) {

    // set the color and stroke for this shape
    fill(high/TAU, 1.0, 1.0, 0.2);
    stroke(high/TAU, 0.4, 0.3, 0.2);

    float overlap = 0.7 + 0.3 * sin(millis() * 0.001 + high);

    beginShape();
    for (float angle=0; angle<TAU; angle+=0.02) {
      float sc = getScale(angle, high + overlap, overlap);
      PVector v = PVector.fromAngle(angle);
      v.mult(200 + 150 * sc + high * 5);
      vertex(v.x, v.y);
    }
    endShape(CLOSE);
  }
}
