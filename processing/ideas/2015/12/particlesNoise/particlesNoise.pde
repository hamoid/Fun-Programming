ArrayList<Vehicle> vehicles;
PGraphics pg;

void setup() {
  size(540, 540, P2D);
  background(0);
  pg = createGraphics(width, height, P2D);
  vehicles = new ArrayList<Vehicle>();
}

void draw() {
  pg.beginDraw();
  for (int i=vehicles.size ()-1; i>=0; i--) {
    Vehicle v = vehicles.get(i);

    v.applyBehaviors(vehicles);
    v.update();
    if (v.r < 1) {
      vehicles.remove(v);
    }
  }
  pg.endDraw();

  image(pg, 0, 0);
  for (Vehicle v : vehicles) {
    v.display();
  }
}
void keyPressed() {
  if (key == 'n') {
    for (int i=0; i<100; i++) {
      vehicles.add(new Vehicle(width/2, height/2));
    }
  }
  if (key =='s') { 
    save("thumb.jpg"); 
    println("saved!");
  }
}
