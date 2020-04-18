int pages = 100;
int[] x = new int[pages];
int[] y = new int[pages];
int[] z = new int[pages];

void setup() {
  size(500, 400, P3D);
  noFill();
  stroke(0, 155, 0);
  smooth();
  for(int p = 0; p<pages; p++) {
    x[p] = int(random(-150, 150));
    y[p] = int(random(-150, 0));
    z[p] = int(random(-150, 150));
  }
}
void draw() {
  background(255);
  
  translate(width/2, height/2);
  
  rotateY(map(mouseX, 0, width, 0, TWO_PI));
  
  //box(300);
  for(int p = 0; p<pages; p++) {
    strokeWeight(1);
    bezier(0, 150, 0, 0, -150, 0, x[p], y[p], z[p], x[p], y[p], z[p]);
    strokeWeight(8);
    point(x[p], y[p], z[p]);
  }
}
