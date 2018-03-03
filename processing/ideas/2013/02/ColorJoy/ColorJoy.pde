/* @pjs crisp=true; 
pauseOnBlur=true; 
*/

void setup() {
  //size(640, 360);
  fullScreen(P2D);
  colorMode(HSB, 1);
  background(0.05);
}
void draw() {
  float F = frameCount / (float) width;
  for (int x=0; x<width; x++) {
    float i = float(x) / width;
    float sat = 0.5 + 0.4 * sin(noise(i*1, 5, F)*14);
    float bri = 0.5 + 0.4 * sin(noise(6, -F, i*5)*21);
    stroke((i+F)%1, sat, bri);
    line(x, height * 0.15, x, height * 0.85);
  }
}