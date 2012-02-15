/* 
    This program generates images.
    It comes up with random positions on the display.
    It uses the random position as input for the noise() function.
    The noise defines a direction. The point moves in that direction.
    For each point in the screen there is a next point defined by the
    noise() function. By moving the point we generate lines. The lines
    seem to converge.
    By drawing with low opacity, lines are not very visible until they
    become "popular".
    The offset is used to travel through the noise space. It's like grabbing
    flat slices of the noise space, and slowly moving the place where we take
    a slice from.
    At the same time, the slice is rotated using noise()
*/

float i = 0;
float oldx;
float oldy;

// Offset is going to keep increasing.
// I start with a random offset so the branches 
// do not always point up at the beginning.
float offset = random(TWO_PI);

void setup() {
  size(500, 500);
  oldx = width / 2;
  oldy = height / 2;
  smooth();
  background(0);
  stroke(255, 100, 33, 5);
}
void draw() {
  background(0);
    
  // 7000 iterations per frame
  for (int rep = 0; rep < 7000; rep++) {
    // noise value for the current position
    float n = noise(oldx/50, oldy/50, offset);
    // angle
    float a = n * TWO_PI + 20 * noise(offset);
    // distance
    float d = random(4, 7);
    // move using distance and angle
    float x = oldx + d * sin(a);
    float y = oldy + d * cos(a);

    //float at = atan2(x-oldx, y-oldy);

    // noise based line strokeWeight
    float w = 20 * noise(0, oldx/50, oldy/50 + offset);
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
  
  // This is used to save 1000 frames on the disk
  
  //saveFrame("/tmp/video/seq-####.tga");
  //if(frameCount > 1000) {
  //  noLoop();
  //}

  // My /tmp folder is a ram disk, so saving is very fast
  // I convert the images to mp4 typing (I've got 4 cores):
  // ffmpeg -i seq-%04d.tga -r 25 -threads 4 video.mp4 
  
  println(1000.0 / (millis() / float(frameCount)));
}

