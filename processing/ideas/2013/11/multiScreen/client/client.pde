import oscP5.*;
import netP5.*;

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
  myBroadcastLocation = new NetAddress("192.168.2.163", 32000);
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
    colorBG = color(
      msg.get(1).floatValue(), 
      msg.get(2).floatValue(), 
      msg.get(3).floatValue()
    );
    colorFG = color(
      msg.get(4).floatValue(), 
      msg.get(5).floatValue(), 
      msg.get(6).floatValue()
    );    
  }
}

