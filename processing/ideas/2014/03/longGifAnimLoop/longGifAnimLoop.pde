import gifAnimation.*;

int totalFrames = 39;
int framesToSave = 0;
int segmentLength = 3;
GifMaker gif;
Rect[] r;
String filename = "noDelays.gif";
String gifsicle = "gifsicle " + filename + " ";

public void setup() {
  size(500, 500);
  rectMode(CENTER);
  noStroke();
  frameRate(3);
  colorMode(HSB);

  initialize();

  gif = new GifMaker(this, filename);
  gif.setRepeat(0);
}
void initialize() {
  r = new Rect[totalFrames / segmentLength];
  for (int i=0; i<r.length; i++) {
    // pass the previous rectangle if it exists
    // so the new rectangle is based on the last one
    if(i > 0) {
      r[i] = new Rect(r[i-1]);
    } else {
      r[i] = new Rect();
    }
  }
}

void draw() {
  background(0);

  int keyFrame = (frameCount % totalFrames) / segmentLength;
  int keyFrameNext = (keyFrame + 1) % r.length;

  float pc = (frameCount % segmentLength) / (float) segmentLength;
  // pc is linear
  // with the next line make it spend more time near the end of the tween  
  pc = 1 - pow(1 - pc, 2);

  Rect r0 = r[keyFrame];
  Rect r1 = r[keyFrameNext];

  float x = lerp(r0.x, r1.x, pc);
  float y = lerp(r0.y, r1.y, pc);
  float w = lerp(r0.w, r1.w, pc);
  float h = lerp(r0.h, r1.h, pc);
  float a = lerp(r0.a, r1.a, pc);

  translate(x, y);
  rotate(a);
  
  fill(frameCount % segmentLength == 0 ? 255 : color(random(255), 255, 255));
  rect(0, 0, w, h);
  
  fill(0);
  rect(0, 0, w-20, h-20);

  if (framesToSave > 0) {
    gif.setDelay(2);
    gif.addFrame();
    gifsicle += " -d" + (frameCount % segmentLength == 0 ? int(random(12, 300)) : 4) 
      + " \"#" + (totalFrames - framesToSave) +"\"";
    println(framesToSave--);
    if (framesToSave == 0) {
      gifsicle += " --colors 128 >withDelays.gif";
      println(gifsicle);
      gif.finish();
      frameRate(3);
    }
  }
}

void keyPressed() {
  if (key == 's') {
    frameRate(60);
    framesToSave = totalFrames;
  }
  if (key == 'r') {
    initialize();
  }
}

class Rect {
  float x;
  float y;
  float w;
  float h;
  float a;
  // totally random rect
  Rect() {
    x = random(width * 0.2, width * 0.4);
    y = random(height * 0.2, height * 0.4);
    w = random(50, 100);
    h = random(50, 100);
    a = HALF_PI * int(random(4));
  }
  // rect created based on another rect
  Rect(Rect r) {
    x = r.x;
    y = r.y;
    w = r.w;
    h = r.h;
    a = r.a;
    switch(int(random(5))) {
      case 0:
        x = width - r.x;
        break;
      case 1:
        y = height - r.y;
        break;
      case 2:
        w = 300 - r.w;
        break;
      case 3:
        h = 300 - r.h;
        break;
      case 4:
        a = r.a + HALF_PI;
        break;
    }
  }
}

