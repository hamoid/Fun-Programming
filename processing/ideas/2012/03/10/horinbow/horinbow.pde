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

// Version 0.02: Object oriented, added the MovingLine class to make the code
// much more readable and maintanable. All variables are now in the range
// 0..1, which makes things simpler. We could have any amount of morphing
// variables and exchange them, since they all have the same range.

int line_amt = 10;
int lookup_length = 200;
PGraphics g;
float[] sine = new float[lookup_length];
float[] ease = new float[lookup_length];
MovingLine[] lineas = new MovingLine[line_amt];

void setup() {
  size(600, 300);
  colorMode(HSB, 1);
  noStroke();
  rectMode(CENTER);
  smooth();

  g = createGraphics(width, height, JAVA2D);  
  g.beginDraw();
  g.colorMode(HSB, 1);
  g.rectMode(CENTER);
  g.smooth();
  drawGradient();
  g.endDraw();

  // Create moving lines
  for (int i=0; i<line_amt; i++) {
    lineas[i] = new MovingLine();
  }

  // Create lookup tables
  for (int i=0; i<lookup_length; i++) {
    float n = float(i) / float(lookup_length-1);
    
    sine[i] = sqrt(1 - pow(n, 2));   
    ease[i] = (n /= 0.5) < 1 ? 0.5 * pow(n, 2) : -0.5 * ((n -= 2)*n - 2);
  }
}
void drawGradient() {
  for (int y=0; y<height; y++) {
    g.stroke(map(y, 0, height, 0.35, 0.15));
    g.line(0, y, width, y);
  }
}
void draw() {
  g.beginDraw();
  for (int i=0; i<line_amt; i++) {
    lineas[i].update();
  }
  g.image(g.get(0, 0, width, height), -1, 0);
  g.endDraw();
  image(g, 0, 0);
  for (int i=0; i<line_amt; i++) {
    lineas[i].draw_cap();
  }
}


