// use the menu File > Save to save your program
// use the menu File > Load to load an existing program

// setup() is called once at the start of the program
void setup() {
  
  // framerate() tells processing how many times per second
  // it should execute draw()
  frameRate(4);
}

void draw() {
  // choose a random background color
  background(random(255), random(255), random(255));
}
