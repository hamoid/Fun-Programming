PImage tex;
void setup() {
  size(900, 900);
  colorMode(HSB);
}

void draw() {
}
void keyPressed() {
  if (key == ' ') {
    loadTexture();
    tex.loadPixels();
    for (int i=0; i<tex.pixels.length; i++) {
      tex.pixels[i] = color(
        hue(tex.pixels[i]), 
        255, 
        brightness(tex.pixels[i])
        );
    }
    tex.updatePixels();
    image(tex, 0, 0, width, height);
  }
  if (key =='s') { 
    save("thumb.jpg"); 
    println("saved!");
  }
}

void loadTexture() {
  File f = new File("/home/funpro/Pictures/n1/Instagram/");
  File[] files = f.listFiles();
  String path = files[(int)random(files.length)].getAbsolutePath();
  println(path);
  tex = loadImage(path);
}
