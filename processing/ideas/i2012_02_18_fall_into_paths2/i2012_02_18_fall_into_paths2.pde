/* 
 This program generates images.

 It comes up with random positions on the display.
 It uses the random position as input for the noise() function.
 The noise defines a direction. The point moves in that direction.
 For each point in the screen there is a next point defined by the
 noise() function. By moving the point we generate lines. The lines
 seem to converge.

 By drawing with low opacity, lines are not very visible until they
 become "popular". The offset is used to travel through the noise 
 space. It's like grabbing flat slices of the noise space, and slowly 
 moving the place where we take a slice from.
 At the same time, the slice is rotated using noise()
 
 Version 2
 Added the Bezerk class, which is a smooth random bezier based interpolator.
 I use it to change viewport x and y values, and to morph the hues and
 saturations of a 5 color palette. Each hue and saturation morphs at a 
 different random speed decided when the program starts.
 
 By Abe Pazos, Feb 2012
 
 */

float i = 0;
float oldx;
float oldy;

Bezerk bezx;
Bezerk bezy;
Bezerk hues[] = new Bezerk[5];
Bezerk sats[] = new Bezerk[5];

// Offset is going to keep increasing.
// I start with a random offset so the branches 
// do not always point up at the beginning.
float offset = random(TWO_PI);

void setup() {
  size(640, 480);
  smooth();
  background(0);
  colorMode(HSB, 1);

  oldx = width / 2;
  oldy = height / 2;

  bezx = new Bezerk(0.01, 10);
  bezy = new Bezerk(0.01, 10);
  for (int i = 0; i<hues.length; i++) {
    hues[i] = new Bezerk(random(0.001, 0.009), 1);
    sats[i] = new Bezerk(random(0.003, 0.01), 0.7);
  }
}
void draw() {
  background(0);

  // 7000 iterations per frame
  for (int rep = 0; rep < 7000; rep++) {
    // noise value for the current position
    float n = noise(oldx/50 + bezx.getVal(), oldy/50 + bezy.getVal(), offset);

    int which = int(n*hues.length);
    stroke(hues[which].getVal(), sats[which].getVal(), 1, 0.02);
    // angle
    float a = n * TWO_PI + 20 * noise(offset);
    // distance
    float d = random(4, 7);
    // move using distance and angle
    float x = oldx + d * sin(a);
    float y = oldy + d * cos(a);

    //float at = atan2(x-oldx, y-oldy);

    // noise based line strokeWeight
    float w = max((40 + 10*sin(offset)) * noise(offset, oldx/50, oldy/50) - 10, 1);
    strokeWeight(w);

    line(oldx, oldy, x, y);

    // if we get out of the screen, jump back in
    if ((x < 0) || (y < 0) || (x > width) || (y > height)) {
      x = random(width);
      y = random(height);
    }  

    oldx = x;
    oldy = y;
  }
  offset += 0.005;
  
  for (int i = 0; i<hues.length; i++) {
    hues[i].next();
    sats[i].next();
  }
  bezx.next();
  bezy.next();

  // This is used to save 1000 frames on the disk

  //saveFrame("/tmp/video/seq-####.tga");
  //if(frameCount > 1000) {
  //  noLoop();
  //}

  // My /tmp folder is a ram disk, so saving is very fast
  // I convert the images to mp4 typing (I've got 4 cores):
  // ffmpeg -i seq-%04d.tga -r 25 -threads 4 video.mp4 

  // print frames per second
  println(1000.0 / (millis() / float(frameCount)));
}

// A random value interpolator based on a never ending bezier curve.
// When we reach destination (t == 1) then the end becomes the 
// beginning, the first control point is a mirror of the last 
// control point to make a smooth transition

class Bezerk {
  float[] bx = new float[4];
  float t = 0;
  float dt;
  float maximo;
  float val;

  Bezerk(float inct, float m) {
    maximo = m;
    dt = inct;
    for (int i = 0; i<4; i++) {
      bx[i] = random(maximo);
    }
    next();
  }
  float getVal() {
    return val;
  }
  void next() {
    t += dt;
    if (t > 1) {
      t = 0;
      bx[1] = bx[3] - (bx[2] - bx[3]);
      bx[0] = bx[3];
      bx[2] = random(maximo);
      bx[3] = random(maximo);
    }
    val = bezierPoint(bx[0], bx[1], bx[2], bx[3], t);
  }
}

