// Draw 100 non-overlapping circles using arrays
// to store their positions and sizes.

int amount = 100;
int currentCircle = 0;

// we need to store the information of previously drawn circles
// so we can compare the current random circle with all previous ones
// and find out if they overlap
float[] x = new float[amount];
float[] y = new float[amount];
float[] radius = new float[amount];

void setup() {
  background(#884422);
  noStroke();
  size(800, 800);
}

void draw() {
  // check if we're done
  if (currentCircle < amount) {
    // come up with a random position and size for the circle 
    x[currentCircle] = random(width);
    y[currentCircle] = random(height);
    radius[currentCircle] = random(5, 50); // try: 200 / (currentCircle+1);

    // compare the current circle to all previous ones.
    // initialize overlap to false
    boolean overlap = false;
    for (int j=0; j<currentCircle; j=j+1) {
      // if the distance between the current circle and one of the other circles
      // is less than they radii added, they overlap.
      if (dist(x[currentCircle], y[currentCircle], x[j], y[j]) < radius[currentCircle] + radius[j]) {
        overlap = true;
      }
    }

    // only draw if they don't overlap. Otherwise we will try again on the next animation frame.
    if (!overlap) {
      ellipse(x[currentCircle], y[currentCircle], 2*radius[currentCircle], 2*radius[currentCircle]);
      // we found a non overlapping circle, so we can move forward to find the next one
      currentCircle = currentCircle + 1;
    }
  }
}