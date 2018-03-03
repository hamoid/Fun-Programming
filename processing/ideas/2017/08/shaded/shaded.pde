PShader s;
boolean shaderActive = true;
// Helper hsluv function that takes 3 float arguments,
// instead of one double[], which is more like typical Processing code.
int hsluvToRgb(float h, float s, float l) {
  double [] c = {h, s, l};
  c = HUSLColorConverter.hsluvToRgb(c);
  return color(
    (float)c[0]*255, 
    (float)c[1]*255, 
    (float)c[2]*255
    );
}
void setup() {
  fullScreen(P3D);
  s = loadShader("ColorFrag.glsl", "ColorVert.glsl");
  rectMode(CENTER);
  textSize(200);
  textMode(SHAPE);
  shader(s);
}
void draw() {
  float t = millis() * 0.0001;
  background(40);
  ortho();
  randomSeed(12);
  pushMatrix();
  translate(width/2, height/2);
  for (int times=0; times<20; times++) {
    float rad = 1000 * noise(t, times, t * 0.111);
    float sz = 10 + rad/3;
    fill(hsluvToRgb(times*10%360, 50, 100 - rad / 10));
    noStroke();
    for (float a=0; a<TAU; a+=TAU/12) {
      pushMatrix();
      rotate(a + TAU * noise(t,rad * 0.0005, t * 0.073));
      translate(rad, 0, random(50));
      float k = random(0.8, 1.2);
      rect(0, 0, sz*k, sz/k, 5 + rad/50);
      popMatrix();
    }
  }
  popMatrix();
  translate(0, 0, 500);
  fill(#EEEEEE);
  text(shaderActive ? "shader ON" : "shader OFF", 50, height - 50);
}
void mousePressed() {
  shaderActive = !shaderActive;
  if(shaderActive) {
      shader(s);
  } else {
    resetShader();
  }
}
void keyPressed() {
  if(key == 's') {
    save(System.currentTimeMillis() + ".png");
  }
}