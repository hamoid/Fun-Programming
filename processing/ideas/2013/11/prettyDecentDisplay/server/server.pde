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

// The included poem was generated at http://www.languageisavirus.com/

// Alternatives to try: WebRTC, socket.io
// Next time bring a 8 port switch and cables, compare performance
// to WIFI.

// Source code based on oscP5 example: oscP5broadcaster 

OscP5 oscP5;
NetAddressList connectedUsers = new NetAddressList();
int myListeningPort = 32000;
int myBroadcastPort = 12000;
int targetUserID = 0;

String oscPatternConnect = "/server/connect";
String oscPatternDisconnect = "/server/disconnect";
String oscPatternLetter = "/letter";

ColorPair colors;
TextReader text;

// true until a key is pressed
boolean waitForClients = true;
// can be used to test with no clients connected
boolean testWithNoClients = true;

void setup() {
  size(900, 600);
  colorMode(HSB);
  noStroke();
  frameRate(25);
  oscP5 = new OscP5(this, myListeningPort);
  colors = new ColorPair();
  text = new TextReader(colors);
}
void draw() {
  if (waitForClients) {
    if (frameCount % 100 == 0) {
      sendTest();
    }
  } 
  else if (millis() > text.nextEventMillis) {
    sendLetter(text.getLetter());
    text.nextLetter();
  }
}
void sendTest() {
  for (int i=0; i<connectedUsers.size(); i++) {
    NetAddress targetUser = connectedUsers.get(i);

    OscMessage msg = new OscMessage(oscPatternLetter);
    msg.add("" + i);
    msg.add(0);
    msg.add(200);
    oscP5.send(msg, targetUser);
  }
}
void keyPressed() {
  waitForClients = false;
}
void sendLetter(String str) {
  if (connectedUsers.size() > 0) {
    OscMessage msg = new OscMessage(oscPatternLetter);
    msg.add(str);
    msg.add(int(colors.bg));
    msg.add(int(colors.fg));

    NetAddress targetUser = connectedUsers.get(targetUserID++ % connectedUsers.size());
    oscP5.send(msg, targetUser);
  }
  if (testWithNoClients) {
    showTest(str);
  }
}
// The server is not supposed to show anything, but this function
// is here for testing purposes.
void showTest(String s) {
  fill(colors.bg);
  rect(text.currentChar * 20, text.currentLine * 20, 20, 20);
  fill(colors.fg);
  textSize(20);
  text(s, text.currentChar * 20, text.currentLine * 20 + 20);
}
// Have we received connect/disconnect attempts via OSC?
void oscEvent(OscMessage theOscMessage) {
  if (theOscMessage.addrPattern().equals(oscPatternConnect)) {
    connect(theOscMessage.netAddress().address());
  }
  else if (theOscMessage.addrPattern().equals(oscPatternDisconnect)) {
    disconnect(theOscMessage.netAddress().address());
  }
}
private void connect(String ip) {
  if (!connectedUsers.contains(ip, myBroadcastPort)) {
    connectedUsers.add(new NetAddress(ip, myBroadcastPort));
    println("Adding "+ip+" to the list.");
  } 
  else {
    println(ip+" is already connected.");
  }
  println("Currently there are "+connectedUsers.list().size()+" remote locations connected.");
}
private void disconnect(String ip) {
  if (connectedUsers.contains(ip, myBroadcastPort)) {
    connectedUsers.remove(ip, myBroadcastPort);
    println("Removing "+ip+" from the list.");
  } 
  else {
    println(ip+" is not connected.");
  }
  println("Currently there are "+connectedUsers.list().size()+" remote locations connected.");
}

