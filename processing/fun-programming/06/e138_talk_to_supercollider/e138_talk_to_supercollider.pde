import oscP5.*;
import netP5.*;

int AMOUNT = 50;
float[] x = new float[AMOUNT];
float[] y = new float[AMOUNT];
float[] speed = new float[AMOUNT];

OscP5 osc;
NetAddress supercollider;

void setup() {
  size(500, 400);
  background(0);
  stroke(255);
  strokeWeight(5);
  
  osc = new OscP5(this, 12000);
  supercollider = new NetAddress("127.0.0.1", 57120);

  int i = 0;
  while(i < AMOUNT) {  
    x[i] = random(0, width);
    y[i] = random(0, height);
    speed[i] = random(1, 5);
    i = i + 1;
  }
}

void draw() {
  background(0);
  
  int i = 0;
  while(i < AMOUNT) {
    point(x[i], y[i]);
  
    x[i] = x[i] - speed[i];
    if(x[i] < 0) {
      OscMessage msg = new OscMessage("/starhit");
      msg.add(map(y[i], 0, height, 0, 1));
      osc.send(msg, supercollider);
      x[i] = width;
    }
    i = i + 1;
  }
}
