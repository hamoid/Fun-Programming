PVector pos, lastpos, center;
float a, r, lasta, lastd, adelay;

void setup() {
  fullScreen(P2D);
  background(0);
  colorMode(HSB);
  blendMode(ADD);
  r = 10;
  center = new PVector(width/2, height/2);
  pos = (PVector.fromAngle(a)).mult(r).add(center.x, center.y);
  adelay = 0;
}
void draw() {
  int stepSize = 12;
  int steps = (int)((TAU * r) / stepSize);
  a += TAU / steps; 
  r += 16.0 / steps;

  if (--adelay < 1) {
    float n = 64 * noise(sin(a * 0.5), r * 0.02);
    PVector target = (PVector.fromAngle(a)).mult(r + n).add(center.x, center.y);
    lastd = PVector.dist(pos, target);
    target.sub(pos);
    lasta = target.heading();
    lasta = lasta < 0 ? lasta + TAU : lasta;
    lasta = (int)((lasta / TAU) * 6);
    adelay = (int)random(3);
  }

  PVector delta = (PVector.fromAngle(lasta * (TAU/6))).mult(lastd);
  pos.add(delta);

  if (lastpos != null) {
    for (int w=32; w>0; w/=2) {
      stroke(20, 100, 6 + 32/w - r/16);
      strokeWeight(w);
      line(lastpos.x, lastpos.y, pos.x, pos.y);
    }
  }
  lastpos = pos.copy();
}
void mousePressed() {
  center.set(mouseX, mouseY);
  r = 10;
}
void keyPressed() {
  if(key == ' ') {
    background(0);
  }
  if(key == 's') {
    save(System.currentTimeMillis() + ".png");
  }
}