void setup() {
  size(1200, 675, P3D);
  colorMode(HSB);
}
void draw() {}
void keyPressed() {
  float h = random(255);
  float s = 200;
  float b = 200;
  float a = random(TWO_PI);
  
  background(h, s, 50);
  noStroke();
  lightFalloff(0.0, 0.0003, 0.0000025);
    
  pointLight(h, s, b, 
    width/2+500*cos(a+0.0*TAU), height/2+500*sin(a+0.00*TAU), 500);
  pointLight((h+85) % 255, s*0.5, b, 
    width/2+500*cos(a+0.33*TAU), height/2+500*sin(a+0.33*TAU), 500);
  pointLight((h+170) % 255, s*0.25, b, 
    width/2+500*cos(a+0.66*TAU), height/2+500*sin(a+0.66*TAU), 500);
    
  for (int step=0; step<8; step++) {
    float n = pow(step + 1, 2.8);
    float sz = 512 / n;
    for (int i=0; i<n; i++) {
      fill(random(100, 255));
      pushMatrix();
      translate(random(width), random(height));
      rotateX(QUARTER_PI);
      rotateY(QUARTER_PI);
      box(sz, sz, sz * (1 + n / 10));    
      rotateY(HALF_PI);
      box(sz, sz, sz * (1 + n / 10));    
      rotateX(HALF_PI);
      box(sz, sz, sz * (1 + n / 10));    
      popMatrix();
    }
  }
}
