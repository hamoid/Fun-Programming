int totalFrames = 32;
int framesToSave = 0;

int[] colors = { #DDDDDD, #AAAAAA, #666666, #222222, #000000 };
int[] shadows = { #FFFFFF, #CCCCCC, #888888, #444444, #222222 };

void setup() {
  size(500, 500, P3D);
  colorMode(HSB);
  noStroke();
  sphereDetail(10);
  background(0);
}
void draw() {
  background(0);
  //filter(BLUR, 6);

  float r = TAU * (frameCount % totalFrames) / float(totalFrames);

  translate(width*0.54, height*0.5);

  int c = 0;
  for (float t=0; t<TAU; t+=0.02) {
    pushMatrix();
    rotate(t);
    translate(width / 3, 0);

    float bdist = (width / 25) * (1.5+sin(t-HALF_PI))/2;
    float bsize = width / 100;

    int peaks = 3;
    for (int n=0; n<colors.length; n++) {
      float ang = n*TAU/colors.length + t*peaks + r;
      float x = cos(t-r);
      float y = sin(t-r);
      ang += atan2(y-0, x-.7);      
      pushMatrix();
      translate(bdist*cos(ang), 0, bdist*sin(ang));
      fill(c % 10 < 7 ? colors[n] : shadows[n]);
      sphere(map(n,0,colors.length, bsize, bdist));
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
