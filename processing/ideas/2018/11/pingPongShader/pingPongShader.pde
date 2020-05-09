
// In Processing there are dropped frames at times
// which I find disturbing, as it breaks
// the smooth horizontal movement. This happens even
// if the frame rate is 60 fps.

// It does not happen in openFrameworks.

PGraphics bufferX, bufferY;
PShader fxBlurX, fxBlurY;
ArrayList<PVector> points = new ArrayList<PVector>();
static final int W = 800;
static final int H = 800;
static final int DEPTHS = 4;
void settings() {
  //fullScreen(P3D);
  // Here it works even if the screen size is lower than the PGraphics size.
  // But for some reason it does not work in the Branches program.
  size(W, H, P3D);
}
void setup() {
  bufferX = createGraphics(W, H, P3D);
  bufferY = createGraphics(W, H, P3D);
  fxBlurX = loadShader("blurRGB_x.frag");
  fxBlurY = loadShader("blurRGB_y.frag");
  for (int i=0; i<100; i++) {
    points.add(new PVector(random(W), random(H)));
  }
}
void rotThing(PGraphics pg, int i) {
  int count = points.size  () / DEPTHS;
  for (int j=i*count; j<i*count+count; j++) {
    PVector p = points.get(j);
    pg.pushMatrix();
    pg.noStroke();
    pg.translate(p.x, p.y);
    pg.fill(200-50*noise(j), 200-50*noise(j+0.1), 200-50*noise(j+0.2));
    pg.textSize(80 - (i + noise(j)) * 20);
    pg.text(j, 0, 0);
    pg.popMatrix();
    p.x -= DEPTHS - i - noise(j);
    if (p.x < -100) {
      p.x = W;
    }
  }
}
void draw() {
  if (bufferY == null) {
    return;
  }
  bufferY.beginDraw();
  bufferY.background(50);
  rotThing(bufferY, DEPTHS-1); // most blurry
  bufferY.endDraw();

  for (int i=DEPTHS-2; i>=0; i--) {

    float d = (i+1)*(i+1);
    float a = 1.0/(1 + i * 0.1);

    fxBlurX.set("blur", d, d+2, d+1, a);
    bufferX.beginDraw();
    bufferX.shader(fxBlurX);
    bufferX.image(bufferY, 0, 0);
    // I don't understand why I need to draw the next
    // layer here with rotThing() instead of below,
    // after applying the second blur. It doesn't make
    // sense to me, but it doesn't work otherwise.
    bufferX.resetShader();    
    rotThing(bufferX, i);
    bufferX.endDraw();

    bufferY.shader(fxBlurY);
    fxBlurY.set("blur", d, d+1, d+2, a);
    bufferY.beginDraw();
    bufferY.image(bufferX, 0, 0);
    bufferY.endDraw();
  }

  image(bufferY, 0, 0);
  fill(255);
  text((int)frameRate, 50, 50);
}
void keyPressed() {
  if (key == 's') {
    save("thumb.png");
  }
}
