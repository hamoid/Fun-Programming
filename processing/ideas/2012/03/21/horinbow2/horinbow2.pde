// I listen to http://www.deepmix.ru while I see beautiful lines move up and down
// and I smile. A few hours ago this was an idea in my head, now I can see it.

// ... We have [line_amt] moving lines.
// Each MovingLine has [var_amt] different variables.
// Each variable has a current value [curr], which is
// a value between [from] and [to].
// [t] indicates how far are we between [from] and [to].
// [delta] indicates how much [curr] has changed since the last frame.
// It's used to calculate the angle using atan2.
// Each variable spends time at [curr]. At random times, it decides to change.
// Then it sets a random target [to], an sets [t] to 1
// and starts counting down to 0 while transitioning between [from] and [to].

// Version 0.0.2: Object oriented, added the MovingLine class to make the code
// much more readable and maintanable. All variables are now in the range
// 0..1, which makes things simpler. We could have any amount of morphing
// variables and exchange them, since they all have the same range.

// Version 0.0.3: Render only the right side of the screen, 
// the rest is scrolled.

int line_amt = 10;
PGraphics gradient;
PGraphics buffer;
MovingLine[] lineas = new MovingLine[line_amt];
int renderWidth = 180;

void setup() {
  size(600, 300);
  frameRate(99);
  colorMode(HSB, 1);
  noStroke();
  rectMode(CENTER);
  smooth();

  // create gradient
  gradient = createGraphics(renderWidth, height, JAVA2D);
  drawGradient(0.35, 0.15);
  
  // cover buffer with gradient
  buffer = createGraphics(width-renderWidth, height, JAVA2D);
  buffer.beginDraw();
  for (int x=0; x<buffer.width; x+=gradient.width) {    
    buffer.image(gradient, x, 0);
  }
  buffer.endDraw();

  for (int x=0; x<width; x+=gradient.width-1) {    
    image(gradient, x, 0);
  }

  for (int i=0; i<line_amt; i++) {
    lineas[i] = new MovingLine(renderWidth);
  }
}
void drawGradient(float tTop, float tBottom) {
  gradient.beginDraw();
  gradient.colorMode(HSB, 1);
  for (int y=0; y<height; y++) {
    gradient.stroke(map(y, 0, gradient.height, tTop, tBottom));
    gradient.line(0, y, gradient.width, y);
  }
  gradient.endDraw();
}
void draw() {
  image(gradient, buffer.width, 0);
  for (int i=0; i<line_amt; i++) {
    lineas[i].update();
  }
  image(buffer, 0, 0);

  buffer.beginDraw();
  // scroll buffer
  buffer.copy(buffer,  0, 0, buffer.width, buffer.height,  -1, 0, buffer.width, buffer.height);
  // copy 1 line
  buffer.copy(g,  buffer.width, 0, 1, height,  buffer.width-1, 0, 1, height);
  buffer.endDraw();
  
  if(frameCount % 50 == 0) {
    println(frameRate);
  }
}


