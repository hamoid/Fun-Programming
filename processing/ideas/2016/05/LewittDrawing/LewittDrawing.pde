import java.net.*;
import java.util.Enumeration;
import processing.net.*;

Client c;
String serverIP = "192.168.3.196";
String input;
int[] data;
int myID;

void setup() {
  size(800, 600);
  frameRate(30);
  c = new Client(this, serverIP, 12345);
  myID = getIpLastNumber();
}

void draw() {
  if (mouseX != pmouseX && mouseY != pmouseY) {
    c.write(myID + " 0 " + mouseX + " " + mouseY + "\n");
  }
}
void mousePressed() {
  c.write(myID + " 1 1\n");
}

int getIpLastNumber() {
  try {
    Enumeration e = NetworkInterface.getNetworkInterfaces();
    while (e.hasMoreElements()) {
      NetworkInterface n = (NetworkInterface) e.nextElement();
      Enumeration ee = n.getInetAddresses();
      while (ee.hasMoreElements()) {
        InetAddress i = (InetAddress) ee.nextElement();
        String ip = i.getHostAddress();
        if (ip.startsWith("192.")) {
          return Integer.parseInt(ip.substring(1+ip.lastIndexOf(".")));
        }
      }
    }
  } 
  catch(Exception ex) {
    ex.printStackTrace();
  }
  return 0;
}