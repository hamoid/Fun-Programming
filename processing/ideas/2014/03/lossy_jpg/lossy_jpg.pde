String PATH = "/tmp/a.jpg";
void setup() {
  size(900, 900);
  background(#16B2B0);
  noStroke();
  fill(#D13A2C);
  PFont f = loadFont("UnBatang-Bold-150.vlw");
  textFont(f);
  translate(120, 200);
  text("growth", 0, 0);
  translate(0, 100);
  text("will", 0, 0);
  translate(50, 80);
  text("tear", 0, 0);
  translate(70, 170);
  text("us", 0, 0);
  translate(200, 230);
  text("apart", 0, 0);
}
void draw() {
  save(PATH);
  image(loadImage(PATH), 0, 0);
  text("growth", 120, 200);
  println(frameCount);
}

