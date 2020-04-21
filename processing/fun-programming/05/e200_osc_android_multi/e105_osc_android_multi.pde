// This code runs only on the Java mode inside the IDE,
// not on Processing.js (web mode).

import oscP5.*;
import netP5.*;

OscP5 osc;

float[] x = new float[5];
float[] y = new float[5];

void setup() {
  size(256, 256);
  smooth();
  osc = new OscP5(this, 10000);

  for(int i = 0; i < 5; i++) {
    x[i] = 0;
    y[i] = 0;
  }
}

void draw() {
  background(0);
  for(int i = 0; i < 5; i++) {
    float w = random(10, 12);
    ellipse(x[i] * width, y[i] * height, w, w);
  }
}

/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage m) {
  String p = m.addrPattern();
  if(p.substring(0, 6).equals("/multi")) {
    int i = Integer.parseInt(p.substring(7)) - 1;
    x[i] = m.get(0).floatValue();
    y[i] = m.get(1).floatValue();
  }
}
