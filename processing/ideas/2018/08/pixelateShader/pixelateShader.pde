PShader shader;

public void setup() {
  fullScreen(P3D);
  shader = loadShader("pixelate.glsl");
  shader.set("res", displayWidth/10.0, displayHeight/10.0);
}

public void draw() {
  background(255);
  lights();
  noStroke();
  translate(width/2, height/2);
  rotateX(frameCount * 0.01);
  rotateY(frameCount * 0.02);
  fill(#224488);
  box(500);
  fill(255);
  sphere(330);
  filter(shader);  
}
