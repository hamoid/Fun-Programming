// Comparing keyPressed and keyPressed()

// Strange: I get some white lines on the top
// while a key is pressed. Should be pure black.

// Observe the repetition delay on the bottom
// when you hold a key down.

int x;
void setup() {
  size(900, 100);
  background(255);
}

void draw() {
  x++;
  if(x == width) {
    x = 0;
    background(255);
  }
  // top area shows keyPresesd variable
  stroke(keyPressed ? 0 : 255);
  line(x, 0, x, 50);
}

void keyPressed() {
  // bottom area shows keyPressed() function calls
  stroke(0);
  line(x, 50, x, 100);
}
