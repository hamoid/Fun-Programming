float a = 0;
ArrayList<Gear> gears;
void setup() {
  size(500, 500);
  frameRate(60);
  gears = new ArrayList<Gear>();
  
  Gear g1 = new Gear(10, false, false);
  Gear g2 = new Gear(5, true, true);
  Gear g3 = new Gear(7, true, false);
  Gear g4 = new Gear(6, true, false);
  Gear g5 = new Gear(8, true, true);
  g1.setPos(width/2, height/2);
  g2.setPos(width/2 + g1.getRadius() + g2.getRadius(), height/2);
  g3.setPos(height/2 - g1.getRadius() - g3.getRadius(), height/2);
  g4.setPos(width/2, height/2 + g1.getRadius() + g4.getRadius());
  g5.setPos(height/2, height/2 - g1.getRadius() - g5.getRadius());
  gears.add(g1);
  gears.add(g2);
  gears.add(g3);
  gears.add(g4);
  gears.add(g5);
}

void draw() {
  background(#7723C1);
  translate(width*0.55, height*0.55);
  rotate(0.4 * sin(a * 2));
  scale(0.8 + 0.4 * sin(a));
  translate(-width/2, -height/2);
  for(Gear g : gears) {
    // TODO: calculate this magic number
    g.rot(4.1887855 + 0.5 * sin(a * 5));
    g.draw();
  }
  a += TAU / 150;
  if(frameCount % 150 == 0) {
    exit();
    println(gears.get(0).getRotation());
  }
  save("/tmp/a/" + nf(frameCount,4) + ".gif");
}
