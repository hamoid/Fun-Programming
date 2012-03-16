// This is a rendering speed test.

// I want to find out if I could render the whole
// set on lines on my Horinbow program, instead of
// rendering just the last line and then moving the
// whole screen one pixel.

// Without threads it turns out it's not fast enough:
// at 600 x 300, 27 frames per second.
// at 300 x 300, 45 frames per second.
// at 150 x 300, 58 frames per second.

// What makes it really slow is smooth(), but I need it.

// One solution is to mix the two options: render the right
// side of the screen (150 pixels wide) and then move the
// remaining 450 pixel to the left, but that makes it
// impossible to change the length of old lines after they
// have been drawn. They are 

// Another option is to use 4 threads, but I don't like the
// idea because many people will have just one cpu.

// One more possiblo optimization is to try deactivating smooth
// when drawing vertical lines, which is the default state in Horinbow.

Renderer t1;
Renderer t2;
Renderer t3;
Renderer t4;

float pTime;
int pReady = 0;
int pAllReady = 0;
int f = 0;

void setup() {
  size(600, 300);
  colorMode(HSB, 1);
  background(0);
  noLoop();
  frameRate(100);

  t1 = new Renderer(1, 0, 1);
  t2 = new Renderer(2, 2, 3);
  t3 = new Renderer(4, 4, 6);
  t4 = new Renderer(8, 7, 9);

  t1.start(); 
  t2.start();    
  t3.start();    
  t4.start();
}

void draw() { // 42 on 1.51, 41 on 2.0a4
  if (f++ % 50 == 0) {
    println((1000*f / millis()) + " : " + (1000*frameCount / millis()) + " : " + frameRate );
  }
}
void render() {
  background(0);
  t1.flash();
  t2.flash();
  t3.flash();
  t4.flash();
  pReady = 0;
  redraw();
}

class Renderer extends Thread {
  PGraphics pGfx;
  int pFrom;
  int pTo;
  int pID;

  Renderer (int tID, int tFrom, int tTo) {
    pID = tID;
    pAllReady |= pID;
    pFrom = tFrom;
    pTo = tTo;
    // each thread renderns on its own PGraphics
    pGfx = createGraphics(width, height, JAVA2D);
    pGfx.beginDraw();
    pGfx.colorMode(HSB, 1);
    pGfx.noStroke();
    pGfx.smooth();
    pGfx.endDraw();
  }
  // place this layer onto the main display
  void flash() {
    image(pGfx, 0, 0);
    // make this layer transparent again
    pGfx.background(0, 0);
    pTime = frameCount / 88.0;
  }
  void run() {
    while (true) {
      boolean act = true;
      synchronized(g) {
        if (pReady == pAllReady) {
          render();
        } 
        else if ((pReady & pID) != 0) {
          // if this thread is done, don't draw
          act = false;
        }
      }
      if (act) {
        pGfx.beginDraw();
        for (int y = pFrom; y <= pTo; y++) {
          float they = noise(y/10.0);
          for (int x=0; x < width; x++) {
            float thex = noise(x/50.0);
            pGfx.fill((they + thex + pTime) % 1.0, 1, 1);
            pGfx.translate(x, 50+y*20);
            pGfx.rotate(6*they - 6*thex - pTime);
            pGfx.rect(0, 0, 1, 15);
            pGfx.resetMatrix();
          }
        }
        pGfx.endDraw();

        // mark this thread as finished
        synchronized(g) {
          pReady |= pID;
        }
      }
      try {
        sleep((long)(8));
      } 
      catch (Exception e) {
        println("Oh " + e);
      }
    }
  }

  void quit() {
    interrupt();
  }
}

