int black;
PGraphics pg;
void setup() {
  size(900, 900, P2D);
  background(0);
  smooth(8);
  blendMode(ADD);
  colorMode(HSB, 3, 100, 1);
  strokeWeight(2);

  black = color(0);

  pg = createGraphics(width, height);
  pg.beginDraw();
  pg.background(black);
  pg.fill(255);
  pg.textSize(400);
  pg.text("we", 250, height-250);
  pg.endDraw();

  grid();
}
void grid() {
  background(0);
  
  int gridSize = 10;
  int margin = 100;
  float distort = 80;
  float zoom = 0.002;

  for (int n=0; n<3; n++) {

    for (float x=margin; x<width-margin; x+=gridSize) {
      for (float lastx=0, lasty=-5000, y=margin; y<width-margin; y+=gridSize) {
        if (lasty < -4000) {
          lastx = x + map(noise(n*0.042, y * zoom, x * zoom), 0.2, 0.8, -distort, distort);
          lasty = y + map(noise(n*0.033, x * zoom, y * zoom), 0.2, 0.8, -distort, distort);
        } else {
          float cx = x + map(noise(n*0.042, y * zoom, x * zoom), 0.2, 0.8, -distort, distort);
          float cy = y + map(noise(n*0.033, x * zoom, y * zoom), 0.2, 0.8, -distort, distort);
          boolean isBg = pg.get((int)x, (int)y) == black;
          stroke(0.1 + n, 100, noise(0.7, y*0.1, x*0.1)- (isBg ? 0.25 : 0.5));
          line(lastx, lasty, cx, cy);
          lasty = cy;
          lastx = cx;
        }
      }
    }

    for (float y=margin; y<width-margin; y+=gridSize) {
      for (float lastx=0, lasty=-5000, x=margin; x<width-margin; x+=gridSize) {
        if (lasty < -4000) {
          lastx = x + map(noise(n*0.042, y * zoom, x * zoom), 0.2, 0.8, -distort, distort);
          lasty = y + map(noise(n*0.033, x * zoom, y * zoom), 0.2, 0.8, -distort, distort);
        } else {
          float cx = x + map(noise(n*0.042, y * zoom, x * zoom), 0.2, 0.8, -distort, distort);
          float cy = y + map(noise(n*0.033, x * zoom, y * zoom), 0.2, 0.8, -distort, distort);
          boolean isBg = pg.get((int)x, (int)y) == black;
          stroke(0.1 + n, 100, noise(x*0.1, y*0.1)- (isBg ? 0.25 : 0.5));
          line(lastx, lasty, cx, cy);
          lasty = cy;
          lastx = cx;
        }
      }
    }
  }
}
void draw() {
}
void keyPressed() {
  if (key == 's') {
    save(System.currentTimeMillis() + ".png");
  }
  if(key == ' ') {
    noiseSeed(frameCount);
    grid();
  }
}
