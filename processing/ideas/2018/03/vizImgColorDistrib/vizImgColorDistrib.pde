PImage img;
PShape shp;
void setup() {
  size(1120, 480, P3D);
  noFill();
  makeShape();
}

void draw() {
  background(0);
  image(img, 0, 0);
  translate(880, 240);
  rotateY(millis() * 0.001);
  rotateZ(millis() * 0.0003);
  stroke(255, 50);
  box(256, 256, 256);
  translate(-128, -128, -128);
  shape(shp, 0, 0);
}

void keyPressed() {
  if (key == ' ') {
    makeShape();
  } else if (key == 's') {
    save(System.currentTimeMillis() + ".png");
  }
}

void makeShape() {
  img = loadImage("http://lorempixel.com/640/480/#.jpg");
  img.loadPixels();

  shp = createShape();
  shp.beginShape(POINTS);
  for (int c : img.pixels) {
    int r = c >> 16 & 0xFF;
    int g = c >> 8 & 0xFF;
    int b = c & 0xFF;
    shp.stroke(c);
    shp.vertex(r, g, b);
  }
  shp.endShape();
}