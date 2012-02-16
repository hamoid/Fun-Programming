// mouse click = draw a new image
// type 's' = save image
// type 'r' = draw new image using the current color settings
// type any other key = darken dark areas

// The most interesting part of this program is that it has
// a recursive function which subdivides the screen in four
// parts, and then each part in four, and so on until reaching
// pixel size. It gives colors to each area while proceeding
// to create interesting patterns. 

// Once in a while they are interesting :)

float x = 0;
float y = 0;
float ha;
float sa;
float ba;
float hb;
float sb;
float bb;
float H;
float S;
float B;

// this function tries to stretch the
// values coming out from noise()
// to cover the full range 0 .. 1
// By default noise() returns values
// near 0.5 most of the time.
float stretch(float y, float expo) {
  if (y < 0.5) {
    y = pow(y*2, expo) / 2;
  } 
  else {
    y = 1 - y;
    y = 1 - pow(y*2, expo) / 2;
  }
  return y;
}
void setup() { 
  size(600, 600); 
  colorMode(HSB, 100);
  noStroke();
  reset();
}
void reset() {
  // TODO: what if these variables depended on X,Y? (use noise)
  ha = random(10, 32);
  sa = random(10, 22);
  ba = random(10, 24);
  hb = 0.07; //random(0.07, 0.7);
  sb = 0.07; //random(0.07, 0.7);
  bb = 0.07; //random(0.07, 0.7);
  H = random(100);
  S = random(100);
  B = random(100);
  drawRect(0, 0, width, color(H, S, B));
}
void drawRect(float x, float y, float s, color c) {
  float s2 = s/2;
  // These formulas try to increase the randomness as
  // we approach pixels size.
  float vh = ha / pow(s, hb);
  float vs = sa / pow(s, sb);
  float vb = ba / pow(s, bb);
  // TODO: try inverting: more variation at large, less when small
  // TODO: try a color palette
  float h = (100 + hue(c)+random(-vh, vh)) % 100;
  color nc = color(
    h, 
    saturation(c)+random(-vs, vs), //100*stretch(noise(h/10), 3), 
    brightness(c)+random(-vb, vb)
  );
  fill(nc);
  rect(x, y, s+1, s+1);
  if (s > 0.8) {
    drawRect(x, y, s2, nc);
    drawRect(x+s2, y, s2, nc);
    drawRect(x, y+s2, s2, nc);
    drawRect(x+s2, y+s2, s2, nc);
  }
}
void draw() {
}
void mousePressed() {
  reset();
}
void keyPressed() {
  
  if (key == 's') {
    save(year() + "-" + month() + "-" + day() + "-" + hour() + "-" + minute() + "-" + second() + ".png");
    println("saved");
    return;
  }
  
  if (key == 'r') {
    drawRect(0, 0, width, color(H, S, B));
    return;
  }
  
  // Attempt to improve the images by darkening
  // dark areas. Not very useful.
  loadPixels();
  int l = pixels.length;
  float minb = 100;
  float maxb = 0;
  for (int i = 0; i < l; i++) {
    float b = brightness(pixels[i]);
    minb = min(minb, b);
    maxb = max(maxb, b);
  }
  for (int i = 0; i < l; i++) {
    color p = pixels[i];
    float a = map(brightness(p), minb, maxb, 0, PI/2);
    pixels[i] = color(hue(p), saturation(p), 100-cos(a)*100);
  }
  updatePixels();
}

