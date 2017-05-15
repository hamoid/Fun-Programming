// Helper hsluv function that takes 3 float arguments,
// instead of one double[], which is more like typical Processing code.
int hsluvToRgb(float h, float s, float l) {
  double [] c = {h, s, l};
  c = HUSLColorConverter.hsluvToRgb(c);
  return color((float)c[0]*255, (float)c[1]*255, (float)c[2]*255);
}

void setup() {
  size(800, 800, P3D);
  background(255);
  rectMode(CENTER);
  textSize(20);
  noStroke();
}

void draw() {
}
void keyPressed() {
  fill(#998877);
  text("HSLUV", 50, height - 50);
  text("HSB", width - 100, 70 );

  colorMode(RGB, 255, 255, 255); 
  translate(width/2, height * 0.66);
  for (int i=0; i<10; i++) {
    pushMatrix();
    rotateY(i * 0.1);
    rotateX(0.3 + i * 0.1);
    float s = 100;
    float l = map(i, 0, 10, 95, 15);    
    for (float h=0; h<360; h+=0.1) {
      fill(hsluvToRgb(h, s, l));
      pushMatrix();
      rotate(radians(h));
      rect(30 + i * 30, 0, 25, 1);
      popMatrix();
    }
    popMatrix();
  }
  
  colorMode(HSB, 360, 100, 100);
  translate(0, -height * 0.45);
  for (int i=0; i<10; i++) {
    pushMatrix();
    rotateY(i * 0.06);
    rotateX(0.1 + i * 0.08);
    float s = 100;
    float l = map(i, 0, 10, 95, 15);    
    for (float h=0; h<360; h+=0.1) {
      fill(h, s, l);
      pushMatrix();
      rotate(radians(h));
      rect(30 + i * 30, 0, 25, 1);
      popMatrix();
    }
    popMatrix();
  }
  //save("result.png");
}