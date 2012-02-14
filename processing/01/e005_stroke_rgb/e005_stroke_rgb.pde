void setup() {
  background(0); // this makes the background black
}

void draw() {
  stroke(0, random(255), 0); // R, G, B

  // the screen is 100 pixels wide and 100 pixels tall
  // lines start at the middle of the screen (50, 50)
  line(50, 50, random(100), random(100) );
}

