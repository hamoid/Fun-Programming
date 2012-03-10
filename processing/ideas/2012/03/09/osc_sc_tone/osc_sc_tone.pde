// Example program to control audio on real time from Processing.
// Processing is sending the mouse x and y values 10 times per second
// inside an OSC message to SuperCollider.
import oscP5.*;
import netP5.*;

OscP5 osc;
NetAddress supercollider;

void setup() {
  size(400, 200);
  frameRate(10);
  osc = new OscP5(this, 12000);
  // destination is SuperCollider, which uses port 57120 by default.
  supercollider = new NetAddress("127.0.0.1", 57120);
}

void draw() {
  // draw is executed 10 times per second.
  // each time Processing sends a message including the mouse position.
  // x is mapped to acceptable frequencies: 200 to 1000 herz
  // y is mapped to acceptable volumes: 0 to 1
  
  OscMessage msg = new OscMessage("/pitchvol");
  msg.add(map(mouseX, 0, width, 200, 1000));
  msg.add(map(mouseY, 0, height, 0, 1));
  osc.send(msg, supercollider); 
}

