void setup() {
  size(500, 500, P3D);
  noFill();
  background(0);
  smooth(8);
  colorMode(HSB);
}

void draw() {
  stroke((frameCount * 0.1) % 256, 255, 200+50*cos(frameCount * 0.01), 20);
  pushMatrix();
  translate(width/2, height/2);
  rotateX(frameCount * 0.003);
  translate(100, 10);
  rotateY(frameCount * 0.005);
  translate(100, 10);
  box(50);
  float x1 = modelX(0, 0, 0);
  float y1 = modelY(0, 0, 0);
  float z1 = modelZ(0, 0, 0);
  popMatrix();

  stroke((frameCount*0.1+128) % 256, 255, 200+50*cos(frameCount * 0.01), 20);
  pushMatrix();
  translate(width/2, height/2);
  rotateY(frameCount * 0.004);
  translate(100, 10);
  rotateZ(frameCount * 0.007);
  translate(100, 10);
  box(50);
  float x2 = modelX(0, 0, 0);
  float y2 = modelY(0, 0, 0);
  float z2 = modelZ(0, 0, 0);
  popMatrix();
  
  stroke(0, 10);
  line(x1, y1, z1, x2, y2, z2);
} 
