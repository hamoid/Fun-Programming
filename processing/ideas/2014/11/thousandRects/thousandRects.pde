void setup() {
  size(900, 900, P3D);
  background(0);
  colorMode(HSB);
  noStroke();
  paint();
}
void paint() {
  float a = randomGaussian() / 10;
  float b = randomGaussian() / 10;
  float c = randomGaussian() / 10;
  for (float i=0; i<1000; i+=0.1) {
    fill(30, 10, 140 + 70 * sin(i * a));
    float z = 20 * sin(i * b);
    float dx = 100 * sin(i * c);    
    pushMatrix();
    translate(width/2, height/2);
    rotate(i*0.03);    
    for (float t = 30; t<400; t*=1.8) {
      beginShape();
      vertex(t + dx, 0, z);
      vertex(t*1.1 + dx, 0, z);
      vertex(t*1.1 + dx, (1000-i), z);
      vertex(t + dx, (1000-i), z);
      endShape(CLOSE);
    }    
    popMatrix();
  }
}
void draw() {}
void keyPressed() {
  if(key == 's') {
    save(System.currentTimeMillis() + ".png");
  }
  if(key == ' ') {
    paint();
  }
}
