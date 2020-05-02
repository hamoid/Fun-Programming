PImage logo;
void setup() {
  size(600, 600);
  background(255);
  logo = loadImage("lacuna_AF-02.png");
}

void draw() {
  image(logo, 100, 200, logo.width * 2, logo.height*2);
  loadPixels();
  for(int x=0; x<width; x++) {
    for(int y=0; y<height; y++) {
      int c = pixels[x + y*width];
      if(brightness(c) < 200) {
        float n = noise(x*0.02, y*0.02, frameCount * 0.01 + 
          2.0 / (0.5 + dist(x,y, width/2,height/2) * 0.01));
        pixels[x + y*width] = n > 0.5 ? #111111 : #EEEEEE; 
      }
    }
  }
  updatePixels();
}
