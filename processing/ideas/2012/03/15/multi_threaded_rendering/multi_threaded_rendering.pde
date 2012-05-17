Renderer r1;
Renderer r2;
Renderer r3;
Renderer r4;

int pWhichReady = 0;         
int pAllReady = (1 << 4) - 1; // 4 threads 
boolean pDrawingLayers = false;

void setup() {
  size(600, 300);
  colorMode(HSB, 1);
  background(0);
  frameRate(100);

  r1 = new Renderer(1 << 0, random(1));
  r2 = new Renderer(1 << 1, random(1));
  r3 = new Renderer(1 << 2, random(1));
  r4 = new Renderer(1 << 3, random(1));

  r1.start();
  r2.start();
  r3.start();
  r4.start();

  noLoop();
}

void draw() {
}

void drawLayers() {
  pDrawingLayers = true;
  background(0);
  r1.drawLayer();
  r2.drawLayer();
  r3.drawLayer();
  r4.drawLayer();
  pWhichReady = 0;
  pDrawingLayers = false;
  redraw();
  
  if (frameCount % 300 == 299) {
    println((1000*frameCount / millis()) + " fps");
  }
}

class Renderer extends Thread {
  PGraphics pGfx;
  float pColor;
  int pID;

  Renderer (int tID, float tColor) {
    pID = tID;
    pColor = tColor;

    pGfx = createGraphics(width, height, JAVA2D);
    pGfx.beginDraw();
    pGfx.colorMode(HSB, 1);
    pGfx.noStroke();
    pGfx.smooth();
    pGfx.endDraw();
  }
  void run() {
    while (true) {
      boolean tThreadDone = false;
      
      synchronized(g) {
        if (!pDrawingLayers && pWhichReady == pAllReady) {
          drawLayers();
        }  
        else if ((pWhichReady & pID) != 0) {
          tThreadDone = true;
        }
      }
      if (!tThreadDone) {        
        pGfx.beginDraw();
        pGfx.fill(pColor, 1, 1);
        pGfx.translate(width/2 + sin(pID + frameCount/20.7)*50, height/2 + sin(pID + frameCount/15.3)*50);
        pGfx.rotate(pID);
        pGfx.rect(0, 0, 20, 100);
        pGfx.resetMatrix();          
        pGfx.endDraw();
          
        synchronized(g) {
          pWhichReady |= pID;
        }
      }
      try {
        sleep(16);
        // not the best approach. See render_speed_test_b, which uses wait() instead. 
      } 
      catch (Exception e) {
        println("Oh " + e);
      }
    }
  }
  void drawLayer() {
    image(pGfx, 0, 0);
         
    pGfx.beginDraw();
    pGfx.background(0, 0);
    pGfx.endDraw();
  }
  void quit() {
    interrupt();
  }
}

