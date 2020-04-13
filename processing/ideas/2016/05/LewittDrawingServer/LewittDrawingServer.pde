import org.funprogramming.P5Helper;
import processing.net.*;
import java.util.Map;

String[] instructions = {
  "Draw together a circle", 
  "Draw together one line", 
  "Draw together a line perpendicular to the circle", 
  "Draw a line parallel to another line", 
  "Draw together a square", 
  "Be all parallel", 
  "All point in the same direction", 
  "Be far away from each other", 
  "Be close to each other"
};

Server s;
Client c;
int frameNum = 0;
String input;
int data[];
HashMap<Integer, Klient> clients = new HashMap<Integer, Klient>();
PGraphics permanent;

void setup() {
  size(800, 600);
  permanent = createGraphics(width, height);
  permanent.beginDraw();
  permanent.background(0);
  permanent.stroke(255);
  permanent.endDraw();
  background(0);
  stroke(255);
  frameRate(30);
  s = new Server(this, 12345);
}

void draw() {
  image(permanent, 0, 0);

  fill(255);
  text(instructions[(millis() / (1000 * 45)) % instructions.length], 30, 30);

  c = s.available();
  if (c != null) {
    input = c.readString();
    input = input.substring(0, input.indexOf("\n"));
    data = int(split(input, ' '));

    int who = data[0];
    int cmd = data[1];

    if (cmd == 0) {
      int x = data[2];
      int y = data[3];
      if (clients.containsKey(who)) {
        Klient k = clients.get(who);
        k.update(x, y);
      } else {
        clients.put(who, new Klient(who, x, y));
      }
    }
    if (cmd == 1) {
      Klient k = clients.get(who);
      k.setClick();
    }
  }

  int players = 0;
  int clicking = 0;
  for (Map.Entry e : clients.entrySet()) {
    Klient k = (Klient)e.getValue();
    if (!k.isOld()) {
      k.draw(this.g);
      players += 1;
      clicking += k.isClicked() ? 1 : 0;
    }
  }
  if (clicking > 0 && players == clicking) {
    for (Map.Entry e : clients.entrySet()) {
      Klient k = (Klient)e.getValue();
      if (!k.isOld() && k.isClicked()) {
        k.draw(permanent);
        k.unClick();
      }
    }
    save("/tmp/a/" + (frameNum++) + ".gif");
  }
}
void keyPressed() {
  if (key == 's') {
    P5Helper.save(this);
  }
}