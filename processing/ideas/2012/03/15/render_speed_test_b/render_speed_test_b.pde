// This version has each thread render its own PGraphic,
// when it finishes it merges it on top of a buffer PGraphic,
// and when all threads have contributed, the result is copied
// to the main display.

// I wanted to try this to see if separating image() calls in time
// would improve speed, but image() doesn't seem to be the bottleneck.

// Test values
int pThreads = 4;
int[] pOpsPerFrame = { 1200, 1400, 1600, 1800 };
int pFrameRate = 100;
long pSleepMs = 8;

// -----------------
Renderer[] pRenderer = new Renderer[pThreads];
float pTime;
int pWhichReady = 0;
int pAllReady = 0;
PGraphics pBuffer;
boolean pCollecting = false;
int[] pOpsList = new int[0];
int f = 0;

void setup() {
  size(600, 300);
  colorMode(HSB, 1);
  background(0);
  noLoop();
  frameRate(pFrameRate);
  pBuffer = createGraphics(width, height, JAVA2D);
  pBuffer.beginDraw();
  pBuffer.background(0);
  pBuffer.endDraw();

  //2.0a4
  //41 real fps, frameRate=41.23, [1000, 1000, 1000, 1000, 1000, 1000] op. per frame, req. frameRate: 100, sleep 8ms
  //41 real fps, frameRate=42.51, [1200, 1200, 1200, 1200, 1200] op. per frame, req. frameRate: 100, sleep 8ms
  //42 real fps, frameRate=46.42, [1100, 1900, 1100, 1900] op. per frame, req. frameRate: 100, sleep 8ms
  //40 real fps, frameRate=41.31, [1500, 1500, 1500, 1500] op. per frame, req. frameRate: 100, sleep 8ms
  //40 real fps, frameRate=43.52, [1800, 2000, 2200] op. per frame, req. frameRate: 100, sleep 8ms
  //39 real fps, frameRate=45.25, [2000, 2000, 2000] op. per frame, req. frameRate: 100, sleep 8ms
  //31 real fps, frameRate=29.99, [3000, 3000] op. per frame, req. frameRate: 100, sleep 8ms
  //26 real fps, frameRate=27.32, [6000] op. per frame, req. frameRate: 100, sleep 8ms
  //Using an intermediate buffer:
  //40 real fps, frameRate=44.89, [1200, 1400, 1600, 1800] op. per frame, req. frameRate: 100, sleep 8ms

  int tFrom = 0;
  int tTo = 0;
  for (int i=0; i<pThreads; i++) {
    int tOps = pOpsPerFrame[i % pOpsPerFrame.length];
    tTo = tFrom + tOps - 1;
    pRenderer[i] = new Renderer(1 << i, tFrom, tTo);
    tFrom = tTo + 1;
    pOpsList = append(pOpsList, tOps);
  }
  for (int i=0; i<pThreads; i++) {
    pRenderer[i].start();
  }
  println("Processing. Please wait...");
}

void draw() {
}
void collectLayers() {
  background(0);
  image(pBuffer, 0, 0);
  
  pBuffer.beginDraw();
  pBuffer.background(0);
  pBuffer.endDraw();

  pTime = frameCount / 88.0;
  pWhichReady = 0;
  pCollecting = false;
  redraw();
  
  if (f++ % 300 == 299) {
    println((1000*f / millis()) + " real fps, frameRate=" + nfc(frameRate, 2) + 
      ", " + Arrays.toString(pOpsList) + " op. per frame, req. frameRate: " + pFrameRate + 
      ", sleep " + pSleepMs + "ms");
  }
}

class Renderer extends Thread {
  PGraphics pGfx;
  int pOpFrom;
  int pOpTo;
  int pID;

  Renderer (int tID, int tOpFrom, int tOpTo) {
    println("New renderer id:" + tID + ", will render from " + tOpFrom + " to " + tOpTo);
    pID = tID;
    pAllReady |= pID;
    pOpFrom = tOpFrom;
    pOpTo = tOpTo;

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
        if (!pCollecting && pWhichReady == pAllReady) {
          pCollecting = true;
          collectLayers();
        } 
        else if ((pWhichReady & pID) != 0) {
          tThreadDone = true;
        }
      }
      if (!tThreadDone) {
        pGfx.beginDraw();
        for (int i = pOpFrom; i <= pOpTo; i++) {
          int y = int(i / width);
          int x = i % width;

          float they = noise(y/10.0); // noise takes away 5 fps
          float thex = noise(x/50.0);

          pGfx.fill((they + thex + pTime) % 1.0, 1, 1);
          pGfx.translate(x, 50+y*20);
          pGfx.rotate(6*they - 6*thex - pTime);
          pGfx.rect(0, 0, 1, 15);
          pGfx.resetMatrix();
        }
        pGfx.endDraw();

        // mark this thread as finished
        pBuffer.beginDraw();
        pBuffer.image(pGfx, 0, 0);
        pBuffer.endDraw();
          
        pGfx.beginDraw();
        pGfx.background(0, 0); // Reset layer to transparent
        pGfx.endDraw();
          
        synchronized(g) {
          pWhichReady |= pID;
        }
      }
      try {
        sleep(pSleepMs);
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

