// I listen to http://www.deepmix.ru while I see beautiful lines move up and down
// and I smile. A few hours ago this was an idea in my head, now I can see it.

// ... We have [line_amt] sets of variables.
// Each set has [var_amt] different variables.
// Each variable has a current value [c], which is
// a value between [v0] and [v1].
// [t] indicates how far are we between [v0] and [v1].
// [delta] indicates how much [c] has changed since the last frame.
// It's used to calculate the angle using atan2.
// Each variable spends time at [c]. At random times, it decides to change.
// Then it sets a random target [v1], an sets [t] to 1 
// and starts counting down to 0 while transitioning between [v0] and [v1].

int line_amt = 10;
int var_amt = 6;
int maxh = 50;

float[][] v0 = new float[var_amt][line_amt]; // from value
float[][] v1 = new float[var_amt][line_amt]; // to value
float[][] c = new float[var_amt][line_amt]; // current value, equal to from if not transitioning
float[][] t = new float[var_amt][line_amt]; // transition time
float[][] delta = new float[var_amt][line_amt]; // delta

// Return a random value in an acceptable range for this kind of variable.
float def(int varn, int linen) {
  switch(varn) {
    case 0: return random(5, maxh); // height
    case 1: return random(maxh/2 + v0[0][linen], height - v0[0][linen] - maxh/2); // y
    case 2: return random(0, 1); // h
    case 3: return random(0.9, 1); // s
    case 4: return random(0.5, 1); // b
    case 5: return random(width-150, width-maxh/2-1); // x
  }
  return 0;
}

void setup() {
  size(600, 300);
  colorMode(HSB, 1);
  rectMode(CENTER);
  for(int y=0; y<height; y++) {
    stroke(map(y, 0, height, 0.35, 0.15));
    line(0, y, width, y);
  }
  noStroke();
  smooth();

  for(int linen=0; linen<line_amt; linen++) {
    for(int varn=0; varn<var_amt; varn++) {
      c[varn][linen] = v0[varn][linen] = v1[varn][linen] = def(varn, linen);
      t[varn][linen] = 0;
    }
  }
}
void draw() {
  for(int linen=0; linen<line_amt; linen++) {       
    for(int varn=0; varn<var_amt; varn++) {
      if(t[varn][linen] > 0) {
        t[varn][linen] -= 0.01;
        if(t[varn][linen] > 0) {
          float n = 1-t[varn][linen]; // 0 .. 1
          // Ease in out quad. Convert n into another number between 0 and 1
          // that spends more time on the extremes, instead of linear.
          // Remove this if/else to see the difference.
          if ((n /= 0.5) < 1) {
            n = 0.5 * pow(n,2);
          } else {
            n = -0.5 * ((n -= 2)*n - 2); 
          }
          delta[varn][linen] = c[varn][linen];
          c[varn][linen] = lerp(v0[varn][linen], v1[varn][linen], n);
          delta[varn][linen] -= c[varn][linen];
        } else {
          v0[varn][linen] = c[varn][linen];
        }
      } else {
        if(random(1000) > 997) {
          v1[varn][linen] = def(varn, linen);
          t[varn][linen] = 1;        
        }
      }
    }

    resetMatrix();
    translate(c[5][linen], c[1][linen]);
    rotate(atan2(delta[1][linen], -1)); // delta[5][linen]-1
    fill(c[2][linen], c[3][linen], c[4][linen]);
    rect(0, 0, 1, c[0][linen]);
    // highlight
    stroke(1, 0.3);
    point(0, c[0][linen]/2);
    // shadow
    stroke(0, 0.3);
    point(0, -c[0][linen]/2);
    noStroke();
    resetMatrix();
  }
  copy(1, 0, width-1, height, 0, 0, width-1, height);
}

