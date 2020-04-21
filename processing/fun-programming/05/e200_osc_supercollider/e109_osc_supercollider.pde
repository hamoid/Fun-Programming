// This code runs only on the Java mode inside the IDE,
// not on Processing.js (web mode).

import oscP5.*;
import netP5.*;

OscP5 osc;
NetAddress dest;

void setup() {
  osc = new OscP5(this, 10000);
  dest = new NetAddress("127.0.0.1", 57120);
}
void draw() {
}
void tellSuperCollider(String cmd) {
  OscMessage msg = new OscMessage(cmd);
  osc.send(msg, dest);
}
void mousePressed() {
  tellSuperCollider("/playit");
}
void mouseReleased() {
  tellSuperCollider("/stopit");
}
