PShader fade;

void setup() {
  size(768, 768, P2D); 
  background(0);
  strokeWeight(3);
  stroke(255);
  fade = loadShader("fade.glsl");
  fade.set("TargetColor", 0.0, 0.0, 0.0);
}
void draw() {
  filter(fade);
  if (mousePressed) { 
    line(mouseX, mouseY, pmouseX, pmouseY);
  }
  if (frameCount % 60 == 0) {
    print(round(frameRate));
  }
}
