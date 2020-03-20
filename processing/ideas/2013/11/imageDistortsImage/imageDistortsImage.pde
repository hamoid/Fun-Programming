PImage a, b;
int[] undo;

// Painting program

// Loads random images from two folders (please configure)
// to act as textures for painting strokes.
// The brush size modulates with time.

// How I use it: I paint a stroke, if I don't like it, press 'u' to undo,
// try again. Get into the rhythm. Wait until the stroke paints thin or thick.
// Observe. Press [SPACE] to change paint colors. Embrace the unpredictable.

// Key shortcuts:
// [DELETE] clears the screen
// 's'      saves image in TIF format
// 'u'      undo last stroke
// [SPACE]  load new random images

// Mouse
// Left mouse button drag to paint a stroke
// Light mouse button drag to paint darker

void loadImages() {
  a = loadImage(getRandomFileFrom("/home/funpro/Pictures/n1/Instagram"));
  a.loadPixels();

  b = loadImage(getRandomFileFrom("/home/funpro/Pictures/n1/Instagram"));
  b.loadPixels();
}

void setup() {
  fullScreen();
  undo = new int[width * height];
  colorMode(HSB);
  background(0);
  noFill();

  loadImages();
}
void draw() {
  if (mousePressed)
    for (int i=0; i<200; i++) {
      float x = map(mouseX + random(-10, 10), 0, width, 0, 1);
      float y = map(mouseY + random(-10, 10), 0, height, 0, 1);

      PVector base = new PVector(x*width, y*height);

      color cb = b.get(int(b.width*x), int(b.width*y));
      float vignetting = 1.0/(1.0 + 3*dist(x, y, 0.5, 0.5));
      if (mouseButton == LEFT)
        stroke(hue(cb), saturation(cb), vignetting * brightness(cb) * random(0.95, 1.05), 40);
      else
        stroke(hue(cb), saturation(cb), vignetting * brightness(cb) * random(0.45, 0.55), 40);

      color ca = a.get(int(a.width*x), int(a.height*y));

      float a0 = hue(ca)/256.0 * TWO_PI * 4;
      float d0 = (brightness(ca) - saturation(ca))/5;
      float dx0 = sin(a0) * d0;
      float dy0 = cos(a0) * d0;
      PVector p0 = new PVector(base.x + dx0, base.y + dy0);

      float a1 = saturation(ca)/256.0 * TWO_PI * 4;
      float d1 = (hue(ca) - brightness(ca)) * (sin(millis()/1000.0)+1.1)/3;
      float dx1 = sin(a1) * d1;
      float dy1 = cos(a1) * d1;
      PVector p3 = new PVector(p0.x + dx1, p0.y + dy1);

      float dist = p0.dist(p3);
      PVector p1 = PVector.add(p3, PVector.mult(PVector.random2D(), dist));  
      PVector p2 = PVector.add(p3, PVector.mult(PVector.random2D(), dist));  

      bezier(p0.x, p0.y, p1.x, p1.y, p2.x, p2.y, p3.x, p3.y);
    }
}

String getRandomFileFrom(String path) {
  File container = new File(path);
  File[] fnames = container.listFiles();
  String name = fnames[int(random(fnames.length))].getAbsolutePath();
  println(name);
  return name;
}
void keyPressed() {
  if (keyCode == DELETE) {
    background(0);
  } else if (key == 's') {
    save(System.currentTimeMillis() + ".tif");
  } else if (key == ' ') {
    loadImages();
  } else if (key == 'u') {
    loadPixels();
    System.arraycopy(undo, 0, pixels, 0, undo.length);
    updatePixels();
  }
}
void mousePressed() {
  loadPixels();
  System.arraycopy(pixels, 0, undo, 0, pixels.length);
}
