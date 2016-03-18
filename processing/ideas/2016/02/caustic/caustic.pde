boolean active = false;
final float step = 0.3;
final float delta = 2;
float scale = 0.005;
float d = 5.5 / scale;
float x = 0;

float tilt(float x, float y) {
  return noise(x * scale, y * scale);
}
void setup() {
  size(900, 900, P2D);
  noiseDetail(4, 0.5);
  background(#2D7E95);
  blendMode(ADD);
  stroke(3);
}
void draw() {
  if (active) {
    if (x < width) {
      scale = map(cos(TWO_PI * x / width), -1, 1, 0.005, 0.004);
      d = 5.5 / scale;
      for (float y=0; y<height; y+=step) {
        float dx = d * (tilt(x - delta, y) - tilt(x + delta, y));
        float dy = d * (tilt(x, y - delta) - tilt(x, y + delta));
        point(x + dx, y + dy);
      }
      x += step;
    }
  }
}
void keyPressed() {
  if(key == ' ') {
    active = true;
  }
  if(key == 's') {
    save("/home/funpro/Desktop/edu/images/" + System.currentTimeMillis() + ".png");
  }
}