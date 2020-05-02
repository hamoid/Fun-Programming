PImage tex;
float sz = 15;
float ppos = 1;
float[] p;
void setup() {
  size(1200, 1200);
  //stroke(0, 25);
  noStroke();
  loadTexture();
  noiseDetail(5, 0.8);
}

void draw() {
  if (sz > 0.002) {
    rotate(0.2);
    int c = tex.get((int)(tex.width*0.5 + tex.width*0.4*cos(frameCount * 0.0005)), 
    (int)(tex.height*0.5 + tex.height*0.4*sin(frameCount * 0.0005)));
    if(ppos == 1) {
      background(c);
    } else {
      fill(c);
    }
    float xx = bezierPoint(p[0], p[1], p[2], p[3], ppos);
    float yy = bezierPoint(p[4], p[5], p[6], p[7], ppos);
    beginShape();
    for (float a=0; a<TAU; a+=0.03) {
      // without frameCount it creates squares, interseting too
      float r = 2*noise(0.5 + 0.4 *cos(a), 0.5 + 0.4*sin(a), frameCount * 0.001)-0.2;
      float x = r * cos(a);
      float y = r * sin(a);
      vertex(xx + sz*width*x, yy + sz*height*y);
    }
    endShape(CLOSE);
    sz = sz * 0.993;
    ppos *= 0.996;
  }
}
void loadTexture() {
  File f = new File("/home/funpro/Pictures/n1/Instagram/");
  File[] files = f.listFiles();
  String path = files[(int)random(files.length)].getAbsolutePath();
  println(path);
  tex = loadImage(path);

  ppos = 1;
  sz = 1;
  
  p = new float[8];
  for(int i=0; i<p.length; i++) {
    p[i] = random(width*0.2, width*0.8);
  }
}
void keyPressed() {
  if (key == ' ') {
    background(0);
    loadTexture();
  }
  if (key == 's') {
    save(System.currentTimeMillis() + ".png");
  }
  if (key == 'z') {
    resetMatrix();
    PImage img = get((int)(width*0.01), (int)(height*0.01), (int)(width*0.98), (int)(height*0.98));
    image(img, 0, 0, width, height);
    filter(BLUR, 2);
  }
}