void setup() {
  fullScreen(P3D);

  // These shaders (found in the data/ folder) are mostly the 
  // standard line shader from Processing, with two differences
  // in the vertex shader:
  
  // One is the variable "thickness" which modulates the strokeWeight.
  
  // The other is the color calculation, at the bottom of the vertex shader,
  // based on the z position of the vertex.
  
  shader(loadShader("LineFrag.glsl", "LineVert.glsl"));
  noFill();
  stroke(100);
  strokeWeight(20);
  frameRate(30);
  bezierDetail(50);
}

void draw() {
  background(255);
  translate(mouseX, mouseY);
  rotateX(frameCount * 0.01);
  rotateY(frameCount * 0.001);
  float T = frameCount * 0.001;
  for (float t=T; t<T+2; t+=0.02) {
    bezier(
      2000*(noise(t)-0.5), 
      2000*(noise(0, t)-0.5), 
      2000*(noise(1, -t)-0.5), 
      2000*(noise(-t, 1)-0.5), 
      2000*(noise(t*t, t)-0.5), 
      2000*(noise(t, t*t)-0.5), 
      2000*(noise(0, 0, t)-0.5), 
      2000*(noise(0, t, -t)-0.5), 
      2000*(noise(t * 1.2)-0.5), 
      2000*(noise(0, t * 1.3)-0.5), 
      2000*(noise(1, -t * 1.4)-0.5), 
      2000*(noise(t, -t*t)-0.5) 
      );
  }  
}
void keyPressed() {
  if (key == ' ') {
    noiseSeed(millis());
  }
  if (key == 's') {
    save(System.currentTimeMillis() + ".png");
  }
}
