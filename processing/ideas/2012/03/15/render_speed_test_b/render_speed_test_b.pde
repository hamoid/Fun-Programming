/*
  This program lets you to render several graphics in parallel,
  each on its own thread.

  It can be used to test different rendering parameters and observe
  the effect on the frame rate.

  Four values can be adjusted:

  - pThreads is the number of threads. Recommended values are between 1 and 8.

  - pOpsPerFrame indicates how many operations per frame each thread will
    do. If this array contains just one value all threads will be evenly
    loaded.
    It's possible to assign uneven load to the threads by using an array with
    several values. For example with 4 threads and pOpsPerFrame being
    { 1200, 1800 } the resulting load on the threads would be
    1200, 1800, 1200 and 1800.

  - pFrameRate is used by frameRate().

  - pSleepMs is the amount of milliseconds each thread sleeps on its main loop.

  If pFrameRate is low, say 30, it will not matter how small pSleepMs is: the
  animation will be slow. This is unexpected since noLoop() has been called
  and redraw() updates the display on demand.

  The Renderer class contains a PGraphics element where it will be drawing.
  pWhichReady contains single bits that indicate if each thread is done rendering.
  When all threads are done, drawLayers() is called. It erases the screen and
  adds all layers on top of the main display.

  Results in Processing 2.0a4:
  41 real fps, frameRate=41.23, [1000, 1000, 1000, 1000, 1000, 1000] op. per frame, req. frameRate: 100, sleep 8ms
  41 real fps, frameRate=42.51, [1200, 1200, 1200, 1200, 1200] op. per frame, req. frameRate: 100, sleep 8ms
  42 real fps, frameRate=46.42, [1100, 1900, 1100, 1900] op. per frame, req. frameRate: 100, sleep 8ms
  40 real fps, frameRate=41.31, [1500, 1500, 1500, 1500] op. per frame, req. frameRate: 100, sleep 8ms
  40 real fps, frameRate=43.52, [1800, 2000, 2200] op. per frame, req. frameRate: 100, sleep 8ms
  39 real fps, frameRate=45.25, [2000, 2000, 2000] op. per frame, req. frameRate: 100, sleep 8ms
  31 real fps, frameRate=29.99, [3000, 3000] op. per frame, req. frameRate: 100, sleep 8ms
  26 real fps, frameRate=27.32, [6000] op. per frame, req. frameRate: 100, sleep 8ms

  Intermediate buffer:
  I tried a different version that had an intermediate buffer where each
  thread writes directly, with the idea of splitting the action of blending
  layers also in threads. The results were:
  40 real fps, frameRate=44.89, [1200, 1400, 1600, 1800] op. per frame, req. frameRate: 100, sleep 8ms
  Using no intermediate buffer I get the same values:
  40 real fps, frameRate=43.15, [1200, 1400, 1600, 1800] op. per frame, req. frameRate: 100, sleep 8ms

  Assumptions:
  - There is a repetitive rendering task to be done that can be split in
    smaller parts which do not depend on each other.
  - The JAVA2D graphic mode is used.

  Conclusions:
  - The speed increase one gets from parallel rendering in Processing using
    this technique is not proportional to the number of threads.
  - In a test laptop with 4 cores and 2.6 Ghz using one thread per core gives the
    best results. In one example with 6000 iterations:
    26 fps using 1 thread, 42 fps using 4 unevenly loaded threads.
    In a different example with 10000 iterations:
    13 fps using 1 thread, 22 fps using 4 unevenly loaded threads
  - It seems that unevenly loading the threads results in a slightly higher frame rate.
  - There is little frame rate differenece in using 3, 4, 5 or 6 threads in the
    test laptop, which is unexpected. It seems that the benefit of distributing
    the work in threads is closely compensated by the added overhead of blending
    the resulting bitmaps together. Another thing to take into account is that
    when 3 threads are created, there are at least 4 present because the main
    program loop runs in its own thread.
  - Running on 1 thread, a program renders more frames per second in Processing 1.5.1 
    than in version 2.0a4 (about 23% higher rate).
  - Running in 4 threads, a program achieves the same frame rate in both 1.5.1 and 2.0a4.
  - When the complexity and / or number of iterations is high enough, using several
    rendering threads may provide a few extra frames per second. For instance, after 
    increasing the iterations to 10000 and changing the drawing algorithm, using one 
    thread gives up to 13 fps, while four threads achieve 22 fps, both in 1.5.1 and 2.0a4.
    That's a 70% increase.
  - Moving the blending of resulting images away from the main program thread
    into each Renderer thread seem to produce no change in the frame rate. This was tested
    by adding an extra PGraphics used by threads to draw their results when done,
    composing each new layer on top of existing layers created by other threads.
    When all threads had contributed, the result was copied onto the main display,
    which means one extra image() operation but less work for the main thread. 
    It was not tested with an increased number of iterations, which might prove this
    extra step is useful under certain conditions.
  
  Notes:
  - The results may be more or less favorable depending on the computer, amount of
    cores and complexity and type of the render loop.

  Discussion:
  - http://forum.processing.org/topic/can-4-threads-draw-in-one-display-at-once
*/


// These test values can be changed to observe the effect on frame rate. 
// The total iteration count should not change between tests if you want to compare results. 
// These examples always do 10000 iterations.
int pThreads = 4; int[] pOpsPerFrame = { 2200, 2400, 2600, 2800 }; // Four threads, uneven load.
//int pThreads = 4; int[] pOpsPerFrame = { 2500 }; // Four threads, even load.
//int pThreads = 3; int[] pOpsPerFrame = { 3333, 3333, 3334 }; // Three threads doing about 3333 iterations each.
//int pThreads = 2; int[] pOpsPerFrame = { 5000 }; // Two threads doing 5000 iterations each.
//int pThreads = 1; int[] pOpsPerFrame = { 10000 }; // One thread doing 10000 iterations.
int pFrameRate = 100;                // Default 100. Try with low values like 5  and 30.
long pSleepMs = 6;                   // Thread sleep time in milliseconds. Try with values between 5 and 20.

// Global variables
Renderer[] pRenderer = new Renderer[pThreads];
float pTime;                         // a time variable used for generating graphics
int pWhichReady = 0;                 // 0000 in binary
int pAllReady = (1 << pThreads) - 1; // 1111 in binary if we have 4 threads
boolean pDrawingLayers = false;      // true while we are drawing the result on the main display
int[] pOpsList = new int[0];         // used just for logging
int f = 0;                           // should be equal to frameCount

void setup() {
  size(600, 300);
  colorMode(HSB, 1);
  background(0);
  frameRate(pFrameRate);

  int tFrom = 0;
  int tTo = 0;
  // create render threads assigning each a work range
  for (int i=0; i<pThreads; i++) {
    int tOps = pOpsPerFrame[i % pOpsPerFrame.length];
    tTo = tFrom + tOps - 1;
    pRenderer[i] = new Renderer(1 << i, tFrom, tTo);
    tFrom = tTo + 1;
    pOpsList = append(pOpsList, tOps); // used for logging
  }
  // after creating the threads, start them
  for (int i=0; i<pThreads; i++) {
    pRenderer[i].start();
  }
  println("Processing. Please wait...");
  noLoop();
}

void draw() {
}
// When all threads have rendered their part we will draw them on the main display.
void drawLayers() {
  pDrawingLayers = true;
  background(0);
  for (int i=0; i<pThreads; i++) {
    pRenderer[i].drawLayer();
  }
  pTime = frameCount / 88.0;
  pWhichReady = 0; // Reset progress indicator. No layers are ready.
  pDrawingLayers = false;
  redraw();

  // Log information once in a while
  if (f++ % 200 == 150) {
    println(nfc(1000.0*f / millis(), 1) + " real fps, frameRate=" + nfc(frameRate, 1) +
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
        // Decide if it's time to flatten the layers
        if (!pDrawingLayers && pWhichReady == pAllReady) {
          drawLayers();
        } // If this layer is ready don't draw it again
        else if ((pWhichReady & pID) != 0) {
          tThreadDone = true;
        }
      }
      if (!tThreadDone) {
        // Here is where all the drawing takes place.
        pGfx.beginDraw();
        for (int i = pOpFrom; i <= pOpTo; i++) {
          float x = width*sin(i / 100.0 + pTime)*0.4;
          float y = height*cos(i / 100.0 + pTime)*0.4;
          float r = noise(x/20, y/20, pTime);
          pGfx.fill(r*1.3, 1, 1);
          pGfx.translate(width/2 + x, height/2 +y);
          pGfx.rotate(10*r);
          pGfx.rect(0, 0, 1, 60*r);
          pGfx.resetMatrix();
        }
        pGfx.endDraw();

        synchronized(g) {
          // mark this thread as done
          pWhichReady |= pID;
        }
      }
      try {
        // wait a few ms before continuing
        sleep(pSleepMs);
      }
      catch (Exception e) {
        println("Oh " + e);
      }
    }
  }
  // Time to drop the current layer on the main display
  void drawLayer() {
    image(pGfx, 0, 0);

    pGfx.beginDraw();
    pGfx.background(0, 0); // Reset layer to transparent
    pGfx.endDraw();
  }
  void quit() {
    interrupt();
  }
}

