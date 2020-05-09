void setup() {
  size(640, 360);
  colorMode(HSB, 1);
  background(0.05);
  noiseDetail(5, 0.5);
}
void draw() {
  float F = frameCount / map(noise(222, frameCount/1200.0), 0, 1, 300, 500);
  float F2 = frameCount / map(noise(-frameCount/777.1, 20), 0, 1, 333, 533);
  for (int x=0; x<width; x++) {
    float i = float(x) / width;
    float bri = 0.5 + 0.5 * sin(noise(6, -F*1.2, i*10)*10) * 
      sin(-F*1.12+i*6.11) *
      (1+sin(F2*2.25-i*6.31)) *
      (0.5+sin(-F*3.51+i*6.21)/2) *
      sin(noise(F2*1.333, -i*9.45, 7)*10.253);
    stroke(bri);
    line(x, 60, x, height-60);
  }
}

void keyPressed() {
    if(key =='s') { save("thumb.jpg"); println("saved!"); }
}
