import oscP5.*;
import netP5.*;
  
OscP5 oscP5;

float x, y, sz;

void setup() {
  size(400,400);
  stroke(255);
  oscP5 = new OscP5(this,12000);  
}

void draw() {
  background(0);
  ellipse(x, y, sz, sz);
  sz *= 0.7;  
}

void oscEvent(OscMessage msg) {
  float freq = msg.get(0).intValue();
  x = map(freq, 40, 89, 50, width-50);
  y = height / 2 + random(-20, 20);  

  float amp = msg.get(1).floatValue();
  sz = map(amp, 0.1, 0.4, 5, 150);
  
  println("SuperCollider says", "freq", freq, "amp", amp);  
}
