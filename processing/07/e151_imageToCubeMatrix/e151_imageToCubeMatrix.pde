PImage img;

void setup() {
  size(600, 600, P3D);
  img = loadImage("M51.jpg");
  img.loadPixels();
  noStroke();
}

void draw() {
  background(255);
  lights();
  translate(width/2, height/2);
  scale(5);
  rotateX(mouseY * 0.01);
  rotateY(mouseX * 0.01);
  //image(img, 0, 0);
  for(int x=0; x<100; x++) {
    for(int y=0; y<100; y++) {
      int imgx = (int)map(x, 0, 100, 0, img.width);
      int imgy = (int)map(y, 0, 100, 0, img.height);
      float bri = brightness(img.get(imgx, imgy));
      if(bri > 50) {
        pushMatrix();
        translate(x, y);
        box(bri/100.0);
        popMatrix();
      }
    }
  }
}

void keyPressed() {
    if(key =='s') { save("thumb.png"); println("saved!"); }
}
