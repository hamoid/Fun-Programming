/*
  Melt writer 25.02.2013
  
  This program scans all the pixels on each draw()
  If pixels are below a brightness threshold, brightness
  is added, and neigboring pixels are darkened.
  
  It searches for neighboring pixels using a spiral pattern,
  looking further and further for available pixels.
 
  Not very efficient.
 
  It would be more efficient to keep a map of active and inactive
  pixels.
 
  Another option would be to affect only immediately neighboring
  pixels, which should then cascade. I did not do that because
  I fear this will provoke a rhombus shape. That's why I currently
  search in a circular pattern with increasing radius.
 
  I would like paint to push outwards. Currently it "jumps" to
  a free location. This works for black and white, but if I was
  using colors it would not work.
 
  I was also considering having a map of freshness, and the paint
  dries with time. The spreading of paint would only happen on
  wet areas. But ideally it should mix colors. 
*/
final int SC_ITEMS = 997;
float sinT[];
float cosT[];
PixelPusher pp;
PGraphics canvas;

void setup() {
  size(400, 400);
  
  canvas = createGraphics(width, height);
  canvas.beginDraw();
  canvas.background(255);
  canvas.strokeWeight(2);
  canvas.stroke(210,100);
  for(int y=0; y<height; y+=4) {
    canvas.bezier(
      0, y, 
      map(noise(11, y/30.3), 0, 1, width*0.25, width*0.5), map(noise(6, y/23.3), 0, 1, y-12, y+12), 
      map(noise(-3, y/11.5), 0, 1, width*0.5, width*0.75), map(noise(y/13.2, 5), 0, 1, y+12, y-12), 
      width, y);
  }
  canvas.stroke(0);
  canvas.endDraw();
  
  sinT = new float[SC_ITEMS];
  cosT = new float[SC_ITEMS];
  for (int i = 0; i < SC_ITEMS; i++) {
    sinT[i] = sin(float(SC_ITEMS) / float(i) * TWO_PI);
    cosT[i] = cos(float(SC_ITEMS) / float(i) * TWO_PI);
  }
  pp = new PixelPusher(200, 2);  
}
void draw() {
  if(mousePressed) {
    canvas.beginDraw();
    canvas.line(pmouseX, pmouseY, mouseX, mouseY);
    pp.updateBwMap();
  }
  canvas.loadPixels();
  int a = frameCount;
  for (int y=0; y<height; y++) {
    for (int x=0; x<width; x++) {
      int i = x+y*width;
      if (pp.inc(i)) {        
        float dist = 1;
        while (true) {
          a = (a + 303) % SC_ITEMS;
          int nx = x + int(dist * sinT[a]);
          int ny = y + int(dist * cosT[a]);
          int i2 = nx+ny*width;
          if(i2>=0 && i2<canvas.pixels.length) {
            if(pp.dec(i2)) {
              break;
            }
          }
          dist = dist + 0.5;
        }
      }
    }
  }
  canvas.updatePixels();
  canvas.endDraw();
  image(canvas, 0, 0);
  fill(#A8BC83);
  text("@fun_pro", width-70, height-10);
}

// Changes the brightness of the given pixel
// if its brightness is above or below the given threshold
class PixelPusher {
  int threshold;
  int brightnessOffset;
  boolean bwMap[];
    
  PixelPusher(int thresh, int off) {
    threshold = thresh;
    brightnessOffset = off;
    
    bwMap = new boolean[canvas.width*canvas.height];
    updateBwMap();
  }
  boolean dec(int which) {
    if(bwMap[which]) {
      int newbri = int(brightness(canvas.pixels[which]) - brightnessOffset);
      canvas.pixels[which] = color(newbri);
      bwMap[which] = newbri > threshold;
      return true;
    } 
    return false;
  }  
  boolean inc(int which) {
    if(!bwMap[which]) {
      int newbri = int(brightness(canvas.pixels[which]) + brightnessOffset);
      canvas.pixels[which] = color(newbri);
      bwMap[which] = newbri > threshold;
      return true;
    } 
    return false;
  }
  void updateBwMap() {
    canvas.loadPixels();
    for(int i=0; i<canvas.pixels.length; i++) {
      bwMap[i] = brightness(canvas.pixels[i]) > threshold;
    }
  }
}

void keyPressed() {
  if(key == 's') {
    save("thumb.png");
  }
}
