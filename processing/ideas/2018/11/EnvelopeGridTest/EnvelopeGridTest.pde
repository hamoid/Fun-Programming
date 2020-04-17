EnvelopeGrid env = new EnvelopeGrid(20);
void setup() {
  fullScreen(P2D);
  rectMode(CENTER);
  noStroke();
}

void draw() {
  if(env.updateTime()) {
    env.setOverlap(random(0.1, 0.9));
    env.setBalance(random(0.2, 0.8));
    env.animateTo(random(0, TAU), (long)random(1000, 10000), (long)random(1000, 3000));
  }
  background(0);
  for (float x = 0.2; x<0.81; x+=.1) {
    for (float y = 0.2; y<0.81; y+=.1) {
      pushMatrix();
      translate(x*width, y*height);
      rotate(env.get(x, y));
      rect(0, 0, 8, 80);
      popMatrix();
    }
  }
}

void keyPressed() {
    if(key =='s') { save("thumb.png"); println("saved!"); }
}
