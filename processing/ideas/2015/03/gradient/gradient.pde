PImage img;
void setup() {
  size(600, 600);
  colorMode(HSB, 100);
  img = createImage(600, 600, RGB);
  img.loadPixels();
  for(int x=0; x<img.width; x++) {
    for(int y=0; y<img.height; y++) {
      float d = 1-abs(x-300)/300.0;
      int c = color(0, 0, map(1-pow(d,4), 1, 0, 100, 70));
      img.pixels[x+y*width] = c;
    }
  }
  img.updatePixels();
  
  tint(200, 100, 50);
  image(img, 0, 0);
}
void draw() {
}
void keyPressed() {
    if(key =='s') { save("thumb.jpg"); println("saved!"); }
}
