int totalFrames = 32;
int framesToSave = 0;

int[] colors = { #FF7600, #057D9F, #000000 };
int[] shadows = { #A64D00, #025167, #222222 };

void setup() {
  size(500, 500, P3D);
  colorMode(HSB);
  noStroke();
  sphereDetail(50);
  background(0);
}
void draw() {
  filter(BLUR, 6);

  float r = TAU * (frameCount % totalFrames) / float(totalFrames);

  translate(width*0.54, height*0.5);

  int c = 0;
  for (float t=0; t<TAU; t+=0.02) {
    pushMatrix();
    rotate(t);
    translate(width / 3, 0);

    float bdist = (width / 25) * (1.5+sin(t-HALF_PI))/2;
    float bsize = width / 100;

    int peaks = 7;
    for (int n=0; n<colors.length; n++) {
      float ang = n*TAU/colors.length + t*peaks + r;
      pushMatrix();
      translate(bdist*cos(ang), 0, bdist*sin(ang));
      fill(c % 10 < 7 ? colors[n] : shadows[n]);
      sphere(bsize+bdist*n/2);
      popMatrix();
    }
    c++;

    popMatrix();
  }
  if(framesToSave > 0) {
    println(framesToSave--);
    saveFrame("/tmp/a/###.tif");
  }
}
void keyPressed() {
  if(key == 's') {
    framesToSave = totalFrames;
  }
}
