float sz = 1;
int frm = 0;
int w2, h2;
void setup() {
  size(900, 900, P2D);
  background(0);
  noFill();
  colorMode(HSB);
  blendMode(ADD);
  w2 = width/2;
  h2 = height/2;
}

void draw() {
  rotate(0.2);

  frm++;
  final float frmm = frm * 0.001;
  stroke(0.1 * frm % 256, 1, 4);
  //stroke(0.1 * frameCount % 256, 100, 150);
  beginShape();
  for (float a=0; a<TAU; a+=0.01) {
    // without frameCount it creates squares, interseting too
    final float x = noise(0.33 + sz * cos(a) * 0.2, frmm);
    final float y = noise(0, 0.42 + sz * sin(a) * 0.2, frmm);
    vertex(w2 + (x-0.5) * 1500, h2 + (y-0.5) * 1500);
  }
  endShape(CLOSE);

  //sz = sz - 0.01;
}
void keyPressed() {
  if (key == ' ') {
    background(0);
  }
  if (key == 's') {
    save(System.currentTimeMillis() + ".png");
  }
  if (key == 'z') {
    resetMatrix();
    blendMode(BLEND);
    PImage img = get((int)(width*0.05), (int)(height*0.05), (int)(width*0.9), (int)(height*0.9));
    image(img, 0, 0, width, height);
    filter(BLUR, 2);
    blendMode(ADD);
  }
  if (key == 'a') {
    blendMode(ADD);
  }
  if (key == 'o') {
    blendMode(SUBTRACT);
  }
}