int FPS = 60;

float k = 400 / 20; // hardcoded 400 height because of my i3wm
float cutY = k * 1000.0 / FPS;
long lastTime;

void setup() {
  //size(1800, 400, JAVA2D);
  //size(1800, 400, P2D);
  size(1800, 400, P3D);

  frameRate(FPS);  
  noStroke();
} 

void draw () {
  long nuTime = System.nanoTime();
  float diff = (nuTime - lastTime) / 1000000.0;
  int x = frameCount % width;
  float y = diff * k;

  fill(0);
  rect(x, 0, 1, height);  

  if (y < cutY) {
    fill(255);
    rect(x, height-y, 1, y);
  } else {
    fill(255);
    rect(x, height-cutY, 1, cutY);
    fill(255, 0, 0);
    rect(x, height-y, 1, y-cutY);
  }

  lastTime = nuTime;
}
