int W2, H2;
Thing thing;
int[] weight = new int[30];
int randomHue = int(random(255));
int randomSat = int(random(255));
float rotSpeed;

void setup() {
  size(640, 360, P3D);
  smooth();
  colorMode(HSB);
  strokeCap(ROUND);
  noiseDetail(8, 0.65);
  W2 = width / 2;
  H2 = height / 2;
  thing = new Thing(0);
  for (int i=0; i<weight.length; i++) {
    weight[i] = int(map(sin(TWO_PI/weight.length*i), -1, 1, 3, 15));
  }
  reset();
}
void reset() {
  rotSpeed = random(200, 900) * (random(100)>50 ? -1 : 1);
  randomHue = int(random(255));
  randomSat = int(random(255));
  thing.reset();
}
void draw() {
  background(0);
  translate(W2, H2);
  rotateY(frameCount/rotSpeed);
  thing.drawLine();
  if (frameCount%90 == 0) {
    reset();
  }
  
  //saveFrame("/tmp/frames/frame-####.png");
  if(frameCount == 30*60) {
    noLoop();
  }
}
void keyPressed() {
  if(key == 's') {
    save("thumb.png");
  }
}
