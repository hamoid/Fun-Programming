int pages = 100;
int[] x = new int[pages];
int[] y = new int[pages];
int[] z = new int[pages];

void setup() {
  size(500, 400, P3D);
  background(0);
  noFill();
  stroke(255);
  smooth();
  strokeWeight(1);
  for(int p = 0; p<pages; p++) {
    x[p] = int(random(-150, 150));
    y[p] = int(random(-150, 150));
    z[p] = int(random(-150, 150));
  }
}
void draw() {
  background(0);
  
  translate(width/2, height/2);
  
  rotateY(frameCount / 100.0);
  
  box(300);
  for(int p = 0; p<pages; p++) {
    line(0, 0, 0, x[p], y[p], z[p]);
  }
}
