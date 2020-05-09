/*
  This program studies what happens when you use noise() or random()
 to define the hue component of a color.
 
 random() covers the whole spectrum and you get all kinds of hues.
 
 noise() does not cover the whole spectrum. Reds, oranges and yellows are missing.
 
 snoise(), a custom function, tries to improve this by stretching the noise()
 values. But red is still missing.
 
 anoise() wraps values around noise() 10 times to avoid bias towards one color
 
 */

float[] n;
Button[] buttons;
String[] butNames = { "noise()", "random()", "snoise()", "random()*random()", "anoise()" };
boolean doWork = true;
int modeID = 2;

void setup() {
  size(500, 500);
  colorMode(HSB, 500);
  n = new float[width];
  reset();
  buttons = new Button[butNames.length];
  for (int i = 0; i<butNames.length; i++) {
    buttons[i] = new Button(i, butNames[i], 20, 40+i*20);
  }
  //noiseDetail(4, 0.8);
}
void reset() {
  for (int i = 0; i<width; i++) {
    n[i] = 0;
  }
  doWork = true;
}
float snoise(float x, float y, float z) {
  float n = noise(x, y, z);
  if (n > 0.5) {
    n = pow(2*(1-n), 3) / 2; // 0.5 .. 1 >> 1 .. 0
    n = 1 - n;
  } 
  else {
    n = pow(2*n, 3) / 2;
  }
  return n;
}
float anoise(float x, float y, float z) {
  float n = (10*noise(x, y, z))%1;
  return n;
}
void calculate() {
  for (int j = 0; j<1000; j++) {
    float rnd = 0;
    switch(modeID) {
    case 0:
      rnd = noise(frameCount/10.0, j/10.0);
      break;
    case 1:
      rnd = random(1);
      break;
    case 2:
      rnd = snoise(frameCount/10.0, j/10.0, 0);
      break;
    case 3:
      rnd = random(1) * random(1);
      break;
    case 4:
      rnd = anoise(frameCount/10.0, j/10.0, 0);
      break;
    }
    if (rnd < 1) {
      int r = int(rnd*width);
      n[r] += 0.6;
      if (n[r] > height) {
        doWork = false;
      }
    }
  }
}
void draw() {
  background(255);
  if (doWork) {
    calculate();
  }
  for (int i = 0; i<width; i++) {
    stroke(i, n[i], n[i]);
    line(i, height, i, height-n[i]);
    stroke(0);
  }
  for (int i = 0; i<butNames.length; i++) {
    buttons[i].draw();
  }
}
class Button {
  int id;
  String t;
  int x;
  int y;
  int w;
  int h;
  Button(int id, String t, int x, int y) {
    this.id = id;
    this.t = t;
    this.x = x;
    this.y = y;
    this.w = int(textWidth(t)) + 20;
    this.h = int(textAscent() + textDescent());
  }
  void draw() {
    boolean inside = mouseOver();
    fill(inside ? 500 : (modeID == id ? 400 : 200));
    rect(x, y, w, h);
    fill(0);
    text(t, x+2, y+h-2);
    if (inside && mousePressed) {
      modeID = id;
      reset();
    }
  }
  boolean mouseOver() {
    return mouseX >= x && mouseX <= x+w && mouseY >= y && mouseY <= y+h;
  }
}
