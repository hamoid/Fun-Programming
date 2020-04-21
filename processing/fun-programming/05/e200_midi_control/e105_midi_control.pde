// This code runs only on the Java mode inside the IDE,
// not on Processing.js (web mode).

import oscP5.*;
import netP5.*;

OscP5 osc;

float[] notes = new float[128];
float[] ccs = new float[128];

void setup() {
  size(300, 300);
  noStroke();
  background(0);
  colorMode(HSB, 1);
  rectMode(CENTER);

  osc = new OscP5(this, 12000);
  osc.plug(this, "note", "/note");
  osc.plug(this, "cc", "/cc");

  for(int i = 0; i < 128; i++) {
    notes[i] = 0;
    ccs[i] = 0;
  }
}

public void note(int vel, int n) {
  notes[n] = vel / 127.0;
}

public void cc(int val, int num) {
  ccs[num] = val / 127.0;
  //println(num);
}

void draw() {
  background(ccs[100], ccs[101], ccs[102]);
  translate(ccs[103] * width, ccs[104] * height);

  for(int i = 0; i < 128; i++) {
    if(notes[i] > 0) {
      float a = map(i, 0, 128, 0, 2 * TWO_PI);
      float sz = notes[i] * 20;
      ellipse(cos(a) * 100, sin(a) * 100, sz, sz);
    }
  }

  rotate(ccs[105] * TWO_PI);
  rect(0, 0, ccs[106] * width, ccs[107] * height);
}

