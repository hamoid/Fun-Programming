Thing[][] ts;
int W = 20;
int H = 10;

void setup() {
  fullScreen(P2D);
  noStroke();
  colorMode(HSB);
  rectMode(CENTER);

  ts = new Thing[W][H];
  for (int x=0; x<W; x++) {
    for (int y=0; y<H; y++) {
      ts[x][y] = new Thing(x, y);
    }
  }
  for (int x=0; x<W; x++) {
    for (int y=0; y<H; y++) {
      ts[x][y].setup(ts);
    }
  }
}
void draw() {
  background(30);
  for (int x=0; x<W; x++) {
    for (int y=0; y<H; y++) {
      ts[x][y].update();
      ts[x][y].draw();
    }
  }
}
void keyPressed() {
  if (key == ' ') {
    for (int i=0; i<20; i++) {
      ts[(int)random(W)][(int)random(H)].randomizeDNA();
    }
  }
  if (key =='s') { 
    save("thumb.jpg"); 
    println("saved!");
  }
}

class Thing {
  private Thing[] things;
  private int x, y;
  private int dna;
  private int dnaPositive, dnaNegative;
  private int frameRate;
  private int frame;
  private float alpha;
  private boolean active;
  PShape shp;

  Thing(int x, int y) {
    this.x = x;
    this.y = y;
    this.frameRate = (int)random(20, 60);
    this.alpha = 0;
    this.active = random(100) < 50;
    randomizeDNA();
  }
  void randomizeDNA() {
    dna = (int)random(16);
    dnaPositive = dnaNegative = 1 << (int)random(4);
    while (dnaNegative == dnaPositive) {
      dnaNegative = 1 << (int)random(4);
    }

    shp = createShape(GROUP);
    for (int i=0; i<4; i++) {
      float shapeRot = -i*TAU/4 - HALF_PI;
      PVector center = PVector.fromAngle(shapeRot);
      center.mult(50);
      PShape tmp = createShape();
      tmp.beginShape();
      if ((dnaPositive & (1 << i)) > 0) {
        tmp.fill(
          (dna*i*129)%256, 
          (dna*i*63)%256, 200);
      } else if ((dnaNegative & (1 << i)) > 0) {
        tmp.fill(40);
      } else {
        tmp.fill(80);
      }
      tmp.noStroke();
      for (float a=0; a<TWO_PI; a+=TWO_PI/(3+(dnaPositive | dnaNegative))) {
        float r = 40 + 20 * sin(a * dnaPositive * dnaNegative);
        tmp.vertex(
          center.x + r * cos(a + shapeRot), 
          center.y + r * sin(a + shapeRot));
      }
      tmp.endShape();
      shp.addChild(tmp);
    }
  }
  void setup(Thing[][] things) {
    this.things = new Thing[4];
    this.things[3] = things[x][(y-1+H) % H]; // up
    this.things[0] = things[(x+1+W) % W][y]; // right
    this.things[1] = things[x][(y+1+H) % H]; // down
    this.things[2] = things[(x-1+W) % W][y]; // left
  }
  void update() {
    if ((++frame % frameRate) == 0) {
      if (random(100) < 0.1) {
        randomizeDNA();
      }
      int pattern = 
        (things[0].active ? 8 : 0) |
        (things[1].active ? 4 : 0) |
        (things[2].active ? 2 : 0) |
        (things[3].active ? 1 : 0);

      int count = 
        (things[0].active ? 1 : 0) +
        (things[1].active ? 1 : 0) +
        (things[2].active ? 1 : 0) +
        (things[3].active ? 1 : 0);

      // TODO: try with positive and negative reinforment. Be happy
      // if neighbor A is there, or if neighbor B is not there. A != B.
      //active = (pattern & dna) > 0; // 3/4 probability, "at least" conditions. additive
      //active = (pattern == dna); // 1/16 probability, "all" conditions
      //active = (pattern ^ dna) > 0;
      //active = count == (dna & 0x11);
      active = 
        //((pattern & dnaPositive) > 0) &&
        ((pattern & dnaNegative) == 0);

      // kinds of possible rules:
      // - number of neigbors active (==, >=, <=, !=)
      // - specific neigbors (which ones and what they should be)
    }
    //alpha = lerp(alpha, active ? 255 : 0, 0.1);
    float step = 255.0/frameRate;
    alpha = constrain(active ? alpha + step : alpha - step, 40, 255);
  }
  void draw() {
    float xx = 2 + (x+0.5) * width/W;
    float yy = 2 + (y+0.5) * height/H;
    xx += 20 * noise(xx * 0.1, yy * 0.1, frameCount * 0.001) - 10;
    yy += 20 * noise(frameCount * 0.001 + 0.5, xx * 0.1, yy * 0.1) - 10;
    pushMatrix();
    translate(xx, yy);
    rotate(noise(frameCount * 0.0013)-0.5);
    shape(shp, 0, 0, alpha/5, alpha/5);
    popMatrix();
  }
}
