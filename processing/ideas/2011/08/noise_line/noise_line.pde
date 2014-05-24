void setup() {
  size(400, 400);
  background(0);
  colorMode(HSB, 1);
  smooth();
}
void draw() {
  fill(0, 0.05);
  noStroke();
  rect(0,0, width, height);
  
  float time_jitter = noise(frameCount-666) * (1 + sin(PI*3/2 + frameCount/1730.0));
  float c = frameCount / 100.0 + time_jitter;
  strokeWeight(noise(c+12) * 20);
  stroke(noise(c), noise(c+74), 1);
  line(
    noise(c+30)*width, noise(c+50)*height, 
    noise(10-c)*width, noise(70-c)*height
  );
}
