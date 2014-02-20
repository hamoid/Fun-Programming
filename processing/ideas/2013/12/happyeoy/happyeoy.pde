int totalFrames = 37;
int framesToSave = 0;

Star[] star = new Star[6000];
void setup() {
  size(500, 500);
  colorMode(HSB);
  
  background(0);
  noStroke();
  writeText();
  initStars();
  background(0);
}
void writeText() {
  fill(255);
  textAlign(CENTER, CENTER);
  PFont f = loadFont("Ume-Gothic-S5-150.vlw");
  textFont(f);
  textLeading(120);
  text("30c3", width/2, height/2);
}
void initStars() {
  for (int i=0; i<star.length; i++) {
    star[i] = new Star();
  }
}
void drawStars() {
  for (int i=0; i<star.length; i++) {
    float p = ((i + frameCount) % totalFrames) / float(totalFrames);
    star[i].draw(p);
  }
}
void draw() {
  background(#001100);
  //fill(0, 150);
  //rect(0, 0, width, height);
  drawStars();
  if(framesToSave > 0) {
    println(framesToSave);
    saveFrame("/tmp/a/####.gif");
    framesToSave--;
  }
}
void keyPressed() {
  if(key == 's') {
    framesToSave = totalFrames;
  }
}
