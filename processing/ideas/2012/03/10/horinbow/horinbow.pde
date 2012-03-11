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
MovingLine[] lineas = new MovingLine[line_amt];

void setup() {
  size(600, 300);
  colorMode(HSB, 1);
  rectMode(CENTER);
  noStroke();
  smooth();
  drawGradient();

  for (int i=0; i<line_amt; i++) {
    lineas[i] = new MovingLine();
  }
}
void drawGradient() {
  for (int y=0; y<height; y++) {
    stroke(map(y, 0, height, 0.35, 0.15));
    line(0, y, width, y);
  }
}
void draw() {
  for (int i=0; i<line_amt; i++) {
    lineas[i].update();
  }
  copy(1, 0, width-1, height, 0, 0, width-1, height);
}

class MovingLine {
  int var_amt = 6;
  int maxh = 50;
  
  // TODO: create new class ValueMorpher
  // then ValueMorpher x = new ValueMorpher(0.003, 0.01) // probability of change, change speed
  // x.update()
  // x.val()
  // Then I can create new number providers, simple like SinOsc, fadeIn, envelopes with/without loop and duration in minutes.
  // or use other easing trasitions
  
  float[] from = new float[var_amt];
  float[] to = new float[var_amt];
  float[] curr = new float[var_amt];  // equal to "from" if not transitioning
  float[] t = new float[var_amt];  // transition time 0..1
  float[] delta = new float[var_amt]; // variable delta
  
  // 0 = height, 5,1 = x,y, 2,3,4 = hsb

  MovingLine() {
    for (int varn=0; varn<var_amt; varn++) {
      curr[varn] = from[varn] = to[varn] = random(1);
      t[varn] = 0;
    }
  }

  void update() {
    for (int varn=0; varn<var_amt; varn++) {
      if (t[varn] > 0) {
        t[varn] -= 0.01;
        if (t[varn] > 0) {
          float n = 1-t[varn]; // 0 .. 1
          // Ease in out quad. Convert n into another number between 0 and 1
          // that spends more time on the extremes, instead of linear.
          // Remove this if/else to see the difference.
          if ((n /= 0.5) < 1) {
            n = 0.5 * pow(n, 2);
          } 
          else {
            n = -0.5 * ((n -= 2)*n - 2);
          }
          delta[varn] = curr[varn];
          curr[varn] = lerp(from[varn], to[varn], n);
          delta[varn] -= curr[varn];
        } 
        else {
          from[varn] = curr[varn];
        }
      } 
      else {
        if (random(1000) > 997) {
          to[varn] = random(1);
          t[varn] = 1;
        }
      }
    }

    float tHeight = map(curr[0], 0, 1, 5, maxh);

    resetMatrix();
    translate(width - 150 + (149-maxh/2) * curr[5], height * 0.1 + height * curr[1] * 0.8);
    rotate(atan2(height * delta[1] * 0.9, -1)); // delta[5]-1 would be more precise, but the effect is the same
    fill(curr[2], 0.9+0.1*curr[3], 0.5+0.5*curr[4]);
    rect(0, 0, 1, tHeight);
    
    // highlight
    stroke(1, 0.3);
    point(0, tHeight/2);
    
    // shadow
    stroke(0, 0.3);
    point(0, -tHeight/2);
    noStroke();
    
    // it's important to resetMatrix(), otherwise copy() breaks
    resetMatrix();
  }
}

