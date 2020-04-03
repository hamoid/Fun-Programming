color bg;
Tracer t;
void setup() {
  size(900, 900);
  colorMode(HSB);
  bg = color(15);
  background(bg);
  noiseSeed(System.currentTimeMillis() % 1000);
  t = new Tracer();
}
void draw() {
  for (int i=0; i<10; i++) {
    t.draw();
  }
}

void keyPressed() {
  if (key=='s') {
    save(int(random(999999)) + ".png");
  }
  if(key=='r') {
    background(bg);
    noiseSeed(System.currentTimeMillis() % 1000);
  }
}