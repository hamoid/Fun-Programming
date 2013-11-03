import oscP5.*;
import netP5.*;

// "Pretty Decent Display"
// Created by Michael Bell and Abe Pazos at the Creative Code Jam
// in Berlin, 2.11.2013

// 1. Start server
// 2. In clients, set right server IP address in the code
// 3. In clients, start sketch, press c to connect
// 4. Sort laptops by number on display
// 5. After all clients connected, press key on server to start
// Server will display text in all available clients

// Source code based on oscP5 example: oscP5broadcastClient

OscP5 oscP5;
NetAddress myBroadcastLocation; 
color colorBG, colorFG;
String letter = "";

String myLetterPattern = "/letter";

void setup() {
  size(800, 600);
  background(0);
  frameRate(25);
  textSize(height);
  textAlign(CENTER, CENTER);
  oscP5 = new OscP5(this, 12000);  
  myBroadcastLocation = new NetAddress("192.168.2.120", 32000);
}

void draw() {
  background(colorBG);
  fill(colorFG);
  text(letter, width * .5 + random(-20, 20), height * .4 + random(-20, 20));
}

void keyPressed() {
  OscMessage m;
  switch(key) {
    case('c'):
    m = new OscMessage("/server/connect", new Object[0]);
    oscP5.flush(m, myBroadcastLocation);  
    break;
    case('d'):
    m = new OscMessage("/server/disconnect", new Object[0]);
    oscP5.flush(m, myBroadcastLocation);  
    break;
  }
}

void oscEvent(OscMessage msg) {
  if (msg.checkAddrPattern(myLetterPattern)) {
    letter = msg.get(0).stringValue();
    colorBG = color(msg.get(1).intValue());
    colorFG = color(msg.get(2).intValue());    
  }
}

