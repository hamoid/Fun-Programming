/*
 Simple rings made out of rectangles.

 To scale down the images: 
 mogrify -filter Gaussian -resize 500x500 -format gif *.png
 
 To convert to anim gif discarding frames and setting delays:
 gifsicle --colors 48 --loop -O2 -d150 i000.gif -d4 i006.gif i010.gif i013.gif i015.gif -d80 i016.gif -d4 i023.gif i027.gif i030.gif i032.gif -d80 i033.gif -d4 i040.gif i044.gif i047.gif i049.gif -d500 i050.gif -d4 i054.gif i060.gif i063.gif i065.gif -d80 i066.gif -d4 i073.gif i077.gif i080.gif i082.gif -d80 i083.gif -d2 i090.gif i094.gif i097.gif i099.gif > /home/funpro/Desktop/rings.gif
 
 */
 
Ring[] ring;
int[] colors = { 
  160, 70, 110
};
int framesTotal = 100, framesToSave = 0;

void setup() {
  size(1000, 1000, P2D);
  noStroke();
  background(50);

  ring = new Ring[colors.length];

  for (int i=0; i<ring.length; i++) {
    ring[i] = new Ring(i);
    ring[i].setSize(width * 0.175, width * 0.275);
    ring[i].setColor(colors[i]);
    float a = i * TWO_PI / colors.length;
    ring[i].setPos(width/2+width * 0.15 * cos(a), height/2+height * 0.15 * sin(a));
  }
}
void draw() {
  background(0);

  drawGrid();

  for (int i=0; i<ring.length; i++) {
    boolean lastRing = i == ring.length - 1;
    // I expected this trick to work with colors too, but for some reason
    // colors are mixed and the effect destroyed. Apparently LIGHTEST does
    // it magic per channel, and not by calculating the color brightness.
    // That's why I use 3 shades of gray instead of bright colors.
    blendMode(lastRing ? LIGHTEST : BLEND);
    ring[i].draw(false);
  }

  //drawEffects();

  if (framesToSave-- > 0) {
    saveFrame("/tmp/a/i###.png");
    println(framesToSave);
  }
}
void drawGrid() {
  blendMode(ADD);
  stroke(90);
  for (int x=20; x<width; x+=50) {
    line(x, 0, x, height);
    line(0, x, width, x);
  }
  noStroke();
}
void drawEffects() {
  PImage img = get();
  filter(DILATE);
  filter(BLUR, 9);
  blendMode(ADD);
  image(img, 0, 0);
}
class Ring {
  float angleOffset, rad0, rad1, x, y;
  int c, id;
  Ring(int id) {
    this.id = id;
    this.angleOffset = id * TWO_PI / colors.length;
  }
  void setSize(float r0, float r1) {
    rad0 = r0;
    rad1 = r1;
  }
  void setColor(int c) {
    this.c = c;
  }
  void setPos(float x, float y) {
    this.x = x;
    this.y = y;
  }
  void draw(boolean testing) {
    float a0, a1;
    int cframe;
    cframe = testing ? framesTotal / 2 : frameCount % framesTotal;
    int hframe = framesTotal / 2;
    if (cframe < hframe) {
      int frm0 = id * hframe / colors.length;
      int frm1 = (id+1) * hframe / colors.length;
      a0 = 0;
      a1 = map(cframe, frm0, frm1, 0, TWO_PI);
      a1 = constrain(a1, 0, TWO_PI);
    } 
    else {
      int frm0 = hframe + id * hframe / colors.length;
      int frm1 = hframe + (id+1) * hframe / colors.length;
      a0 = map(cframe, frm0, frm1, 0, TWO_PI);
      a0 = constrain(a0, 0, TWO_PI);
      a1 = TWO_PI;
    }
    a0 += angleOffset;
    a1 += angleOffset;
    fill(c);
    pushMatrix();
    translate(x, y);
    beginShape(QUAD_STRIP);
    for (float a=a0; a<a1; a+=0.1) {
      vertex(rad1 * cos(a), rad1 * sin(a));
      vertex(rad0 * cos(a), rad0 * sin(a));
    }
    vertex(rad1 * cos(a1), rad1 * sin(a1));
    vertex(rad0 * cos(a1), rad0 * sin(a1));
    endShape();
    popMatrix();
  }
}
void keyPressed() {
  if (key == 's') {
    framesToSave = framesTotal;
  }
}

