VideoOutput vo;

void setup() {
  size(800, 600);
  frameRate(30);
  
  vo = new VideoOutput(this.g, sketchPath, "rectangle.mp4", 30);
}
void draw() {
  background(#4D740C);
    
  pushMatrix();
  translate(width/2 + width/4 * sin(frameCount * 0.013), height/2 + height/4 * cos(frameCount * 0.013));
  rotate(frameCount * 0.001);
  rect(0, 0, 100 + 80 * sin(frameCount * 0.023), 100 + 80 * sin(frameCount * 0.037));
  popMatrix();
  
  if(mousePressed) {
    vo.saveFrame();
    text("Recording...", 80, 80);
  } else {
    text("Hold down mouse button to record.", 80, 80);
  }
}
void keyPressed() {
  vo.close();
  exit();
}
