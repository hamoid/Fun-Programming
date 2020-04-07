float t, dt;
PShader fx;
void setup() {
  size(1000, 1000, P3D);
  noStroke();
  //noiseSeed(1);
  colorMode(HSB);

  fx = loadShader("LightFrag.glsl", "LightVert.glsl");
  shader(fx);
}
float mapConstrained(float v, float a, float b, float A, float B) {
  return constrain(map(v, a, b, A, B), A, B);
}
void draw() {
  background(255);
  ortho();
  camera(-1200, -1200, -1000, 0, 0, -100, 0, 1, 0);
  directionalLight(0, 0, 255, 80, 40, 20);
  rotateY(frameCount * 0.001);
  t += dt;
  dt = noise(frameCount * 0.002) * 0.01 - 0.003;
  for (int i=0; i<100; i++) {
    fx.set("axis", i % 3);
    pushMatrix();
    float x = mapConstrained(pow(noise(t+1.1, i*0.3 + 1.1), 2.0), 0.1, 0.6, -250, 250);
    float y = mapConstrained(pow(noise(i*0.3 + 3.3, t+2.2), 2.0), 0.1, 0.6, -250, 250);
    float z = mapConstrained(pow(noise(5.5, t+3.3, i*0.3), 2.0), 0.1, 0.6, -250, 250);
    translate(x+i, y+i*3, z+i);
    float sz = 50 + 800 * pow(i/100.0, 2);
    float w = mapConstrained(pow(noise(t+4.4, i*0.1, 2.2), 2.0), 0.15, 0.6, sz*0.1, sz);
    float h = mapConstrained(pow(noise(i*0.1, 4.4, t+5.5), 2.0), 0.15, 0.6, sz*0.1, sz);
    float d = mapConstrained(pow(noise(6.6, t+6.6, i*0.1), 2.0), 0.15, 0.6, sz*0.1, sz);
    fill(i*0.5, 20, 150 + i);
    box(w, h, d);
    popMatrix();
  }
}
void keyPressed() {
  if (key == 's') {
    save("thumb.jpg");
  }
}
void mousePressed() {
  hint(DISABLE_OPTIMIZED_STROKE);
}
void mouseReleased() {
  hint(ENABLE_OPTIMIZED_STROKE);
}
