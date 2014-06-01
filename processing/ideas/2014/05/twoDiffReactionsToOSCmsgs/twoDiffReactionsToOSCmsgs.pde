import oscP5.*;
import netP5.*;

OscP5 osc;
NetAddress supercollider;

void setup() {
  osc = new OscP5(this, 12000);
  // Get the next values from SuperCollider 
  // evaluating: NetAddr.localAddr
  supercollider = new NetAddress ("127.0.0.1", 57120);
}

void draw() {
  // To avoid sending 60 messages per second,
  // only send a message every 10 frames
  
  // Find out yourself how many messages you can send
  // per second. You can send a lot, but not millions :)
  if (frameCount % 10 == 0) {
    OscMessage msg = new OscMessage ("/length");
    msg.add(100 + noise(frameCount) * 300);
    osc.send(msg, supercollider);
  }
}

