boolean saving = false;
int framesTotal = 90;
int framesSaved = 0;
void setup() {
  size(540, 540, P3D);
  shader(loadShader("LineFrag.glsl", "LineVert.glsl"));
  noFill();
  stroke(#D28376);
  strokeWeight(20);
  frameRate(30);
}

void draw() {
  background(#2C2A3E);
  translate(width/2, height/2);
  float t = TAU * frameCount / framesTotal;
  for (float sz=100; sz<height*3; sz+= 50) {
    float y = 75 * sin(t + sz);
    ellipse(0, y, sz * 0.7, sz * 0.7);
  }
  if (saving) {
    save("/tmp/a/" + nf(framesSaved++, 2) + ".png");
    if(framesSaved == framesTotal) {
      exit();
    }
  }
}
void keyPressed() {
  if(key == 's') {
    saving = true;
  }
}
