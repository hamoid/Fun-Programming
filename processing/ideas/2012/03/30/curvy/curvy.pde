/* @pjs pauseOnBlur="true"; */

/*

  For some reason, this program only works in JavaScript mode.
  That means Processing 2.0 or higher is required.

  Click to draw a new one.

*/

Tentacle t1;
Tentacle t2;
int TentNum;

int pgn = 0;
PGraphics[] pg = new PGraphics[2];

color dark = #1C1B18;
color bright = #E5E4DE;
color bg = #505050;

void setup() {
  size(500, 600);
  frameRate(10);
  cleanLayers(true);
  newTentacles();
}
void cleanLayers(boolean create) {
  background(bg);
  TentNum = int(random(3, 7));

  for (int i=0; i<2; i++) {
    if (create) {
      pg[i] = createGraphics(width, height, JAVA2D);
    }
    pg[i].beginDraw();
    pg[i].smooth();    
    pg[i].fill(bright);
    pg[i].stroke(dark);    
    pg[i].background(0, 0);
    pg[i].endDraw();
  }
}
void newTentacles() {
  if (TentNum-- > 0) {
    t1 = new Tentacle();
    t2 = new Tentacle(t1.x2, t1.y2, t1.x1, t1.y1);
  } 
  else {
    sayBye();
    noLoop();
  }
}
void draw() {
  background(bg);

  if (t1.done && t2.done) {
    newTentacles();
  }
  pg[pgn].beginDraw();
  pg[pgn].background(0, 0);
  t1.drw(pg[pgn]);
  t2.drw(pg[pgn]);
  pg[pgn].image(pg[(pgn+1)%2], 0, 0);
  pg[pgn].endDraw();
  image(pg[pgn], 0, 0);

  pgn = (pgn+1) % 2;
}
class Tentacle {
  int segment = 0;
  boolean done = false;
  float x1;
  float y1;
  float x2;
  float y2;
  float aperture = 0;

  void init() {
    segment = 0;
    done = false;
  }
  Tentacle(float x1, float y1, float x2, float y2) {
    init();
    this.x1 = x1;
    this.y1 = y1;
    this.x2 = x2;
    this.y2 = y2;
  }
  Tentacle() {
    init();
    x1 = random(width);
    y1 = random(height);
    float rad = random(50, 150);
    x2 = x1 + cos(random(TWO_PI))*rad;
    y2 = y1 + sin(random(TWO_PI))*rad;
  }
  void drw(PGraphics pg) {
    float d = dist(x1, y1, x2, y2) / random(1, 1.8);   
    if (d < 2 || !in()) {
      done = true;
    }

    float p = atan2(y2-y1, x2-x1) - PI / 2; // perpendicular
    float p1 = random(p - aperture, p);
    float p2 = random(p, p + aperture);

    float cx1 = x1 + cos(p1)*d;
    float cy1 = y1 + sin(p1)*d;
    float cx2 = x2 + cos(p2)*d;
    float cy2 = y2 + sin(p2)*d;

    if (segment == 0) {
      pg.stroke(bright);
      pg.line(x1, y1, x2, y2);
      pg.stroke(dark);
    }

    // random spot
    float rpt = random(0, 1);
    float rx2 = bezierPoint(x1, cx1, cx2, x2, rpt);
    float ry2 = bezierPoint(y1, cy1, cy2, y2, rpt);
    pg.strokeWeight(d/20);
    pg.point(rx2, ry2);
    pg.strokeWeight(1);

    // The Curve
    pg.bezier(x1, y1, cx1, cy1, cx2, cy2, x2, y2);

    // Choose random range for next curve
    float w = random(0.5, 1);
    float t1 = random(0, 1-w);
    x1 = bezierPoint(x1, cx1, cx2, x2, t1);
    y1 = bezierPoint(y1, cy1, cy2, y2, t1);
    float t2 = t1 + w;
    x2 = bezierPoint(x1, cx1, cx2, x2, t2);
    y2 = bezierPoint(y1, cy1, cy2, y2, t2);

    aperture = 0.5;
    segment++;
  }
  boolean in() {
    return x1>0 && x1<width && x2>0 && x2<width && y1>0 && y1<height && y2>0 && y2<height;
  }
}
void mousePressed() {
  cleanLayers(false);
  newTentacles();
  loop();
}

// Using a very simple algorithm,
// find the largest empty space 
// on the screen and write a random word.
void sayBye() {
  pg[pgn].loadPixels();
  noStroke();
  fill(#585858);

  int foundX = 0, foundY = 0;
  int foundDist = 0;

  for (int x=0; x<width; x+=30) {
    for (int y=0; y<height; y+=30) {
      int c = pg[pgn].pixels[x + y*width];
      if (c != 0) {
        if (random(10) > 8) {
          ellipse(x, y, 40, 40);
        }
      } 
      else {
        point(x, y);
        int closest = min(width - x, x, min(y, height - y));
        int n;
        for (n = 10; n<closest; n+=30) {
          if (pg[pgn].pixels[x+n + y*width] != 0 ||
            pg[pgn].pixels[x-n + y*width] != 0 ||
            pg[pgn].pixels[x + (y+n)*width] != 0 ||
            pg[pgn].pixels[x + (y-n)*width] != 0) {
            break;
          }
        }
        if (n > foundDist) {
          foundDist = n;
          foundX = x;
          foundY = y;
        }
      }
    }
  }

  // generate random word
  fill(#BFBCAD);
  char data[] = new char[int(random(3, 7))];
  for (int i = 0; i<data.length; i++) {
    data[i] = char(int(random(30, 100)));
  }
  String t = new String(data);
  
  PFont f = createFont("monospace", 12);
  textFont(f);
  textSize(12);
  
  text(t, foundX - textWidth(t)/2, foundY);
}
