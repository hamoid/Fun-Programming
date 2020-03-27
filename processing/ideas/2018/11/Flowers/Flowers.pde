// Press [space] to generate one flower
// Press [s] to save

ArrayList<Flower> flowers;
void settings() {
  size(800, 800, P3D);
}
void setup() {
  flowers = new ArrayList<Flower>();
  textAlign(CENTER, CENTER);
  textSize(230);
}
void draw() {
  background(#678FAF);
  for (Flower f : flowers) {
    f.draw();
  }  
  fill(255);
  text("paljon", width/2, height * 0.2);
  text("onnea", width/2, height * 0.8);
}
void keyPressed() {
  if (key == ' ') {
    flowers.add(new Flower());
  }
  if (key == 's') {
    save("happy-65-"+System.currentTimeMillis()+".png");
  }
}
