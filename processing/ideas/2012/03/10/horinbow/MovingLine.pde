class MovingLine {
  int var_amt = 6;
  int maxh = 50;
  
  float pHeight;
  color pColor;
  PMatrix pMatrix;

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
          delta[varn] = curr[varn];
          curr[varn] = lerp(from[varn], to[varn], ease[int(n*lookup_length)]);
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

    pHeight = map(curr[0], 0, 1, 5, maxh);
    pColor = color(curr[2], 0.9+0.1*curr[3], 0.5+0.5*curr[4]);

    g.translate(width - 150 + (149-maxh/2) * curr[5], height * 0.1 + height * curr[1] * 0.8);
    g.rotate(atan2(height * delta[1] * 0.9, delta[5]-1));
    g.fill(pColor);
    g.rect(0, 0, 1, pHeight);

    // highlight
    g.stroke(1, 0.3);
    g.point(0, pHeight/2);

    // shadow
    g.stroke(0, 0.3);
    g.point(0, -pHeight/2);
    g.noStroke();

    pMatrix = g.getMatrix();
    // it's important to resetMatrix(), otherwise copy() breaks
    g.resetMatrix();
  }
  void draw_cap() {
    setMatrix(pMatrix);
    fill(pColor);
    for(float x=0; x<pHeight/2; x++) {
      rect(-x, 0, 1, pHeight * sine[int(map(x*2, 0, pHeight, 0, lookup_length-1))]);
    }
    resetMatrix();    
  }
}

