AnimGif animgif;
RotCir[] gear;

void setup() {
  size(500, 500);
  frameRate(30);
  noStroke();
  
  animgif = new AnimGif(47, "/tmp/a/frm");
  gear = new RotCir[90];
  
  for (int i=0; i<gear.length; i++) {
    if (random(100) < 50) {
      gear[i] = new RotCir(
      width * 0.33 + 30*randomGaussian(), 
      height * 0.66 + 30*randomGaussian(), 
      140 + 20*randomGaussian(), 
      int(random(5)), 
      int(random(20)), 
      1);
    } 
    else {
      gear[i] = new RotCir(
      width*.66+30*randomGaussian(), 
      height*.33+30*randomGaussian(), 
      100+20*randomGaussian(), 
      int(random(5)), 
      int(random(20)), 
      -1);
    }
  }
}
void draw() {
  background(11, 22, 33);
  for (int i=0; i<gear.length; i++) {
    gear[i].draw(animgif.time);
  }
  animgif.tick();
}

void keyPressed() {
  if (key == 's') {
    animgif.startSave();
  }
}

class RotCir {
  float x, y, rad;
  int sz, amt, dir;
  RotCir(float x, float y, float rad, int sz, int amt, int dir) {
    this.x = x;
    this.y = y;
    this.rad = rad;
    this.sz = sz;
    this.amt = amt;
    this.dir = dir;
  }
  void draw(float t) {
    for (int i=0; i<amt; i++) {
      float aOffset = dir * (TWO_PI/amt) * t;
      float aThis = i/(float)amt * TWO_PI;
      float cx = x + rad * cos(aOffset + aThis);
      float cy = y + rad * sin(aOffset + aThis);
      fill(255, random(150, 250));
      ellipse(cx, cy, sz, sz);
      fill(255, random(20, 80));
      ellipse(cx, cy, sz*2, sz*2);
    }
  }
}

class AnimGif {
  int framesTotal;
  int framesToSave;
  float time;
  String savePath;
  AnimGif(int frames, String savePath) {
    this.framesTotal = frames;
    this.framesToSave = 0;
    this.savePath = savePath;
  }
  void tick() {
    if (framesToSave > 0) {
      saveframe();
    }
    time = (frameCount % framesTotal) / (float)framesTotal;
  }
  void saveframe() {
    String frameCurrent = nf(framesTotal - framesToSave, 4);
    saveFrame(savePath + frameCurrent + ".gif");
    framesToSave--;
    println("frames to save:", framesToSave);
  }
  void startSave() {
    framesToSave = framesTotal;
  }
}
