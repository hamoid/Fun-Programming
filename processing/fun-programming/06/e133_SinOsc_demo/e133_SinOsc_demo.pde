void setup() {
  size(700, 500);
  strokeWeight(2);
  stroke(#89F21B);
  noFill();
}
void draw() {
  background(#264308);
  beginShape();
  for (float x=0; x<width; x++) {
    float freq = 10 * (x / width * TWO_PI);
    float phase = 0;
    float mul = 250;
    float add = 250;
    float y = mul * sin(phase + freq) * 
      sin(freq * 1.7) * sin(freq * 0.33) + add;
    vertex(x, y);
  }
  endShape();
}
