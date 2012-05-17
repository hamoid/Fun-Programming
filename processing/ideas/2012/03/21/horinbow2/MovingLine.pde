class MovingLine {
  int pMaxH = 50;
  int pCurrSeg = 0;
  int pNumSeg;
  Segment[] pSeg;

  // Create new number providers like SinOsc, fadeIn,
  // envelopes with/without loop and duration in minutes.
  // ValueMorpher pY = new SinOsc(height * 0.1, height * 0.9, 0.01);

  // Use other easing trasitions

  ValueMorpher pHeight;
  ValueMorpher pX;
  ValueMorpher pY;
  ValueMorpher pH;
  ValueMorpher pS;
  ValueMorpher pB;

  MovingLine(int tNumSeg) {
    pNumSeg = tNumSeg;
    pSeg = new Segment[pNumSeg];
    pHeight = new ValueMorpher(5, pMaxH, 0.01, 0.003);
    pX = new ValueMorpher(width - 150, width - pMaxH/2 - 1, 0.005, 0.003);
    pY = new ValueMorpher(height * 0.1, height * 0.9, 0.01, 0.003);
    pH = new ValueMorpher(0, 1, 0.01, 0.003);
    pS = new ValueMorpher(0.9, 1, 0.01, 0.003);
    pB = new ValueMorpher(0.5, 1, 0.01, 0.003);

    for(int i=0; i<pNumSeg; i++) {
      pSeg[i] = new Segment(0, 0, 0, 0, 0);
    }
  }

  void update() {
    pX.update();
    pY.update();
    pHeight.update();

    color c = color(pH.update(), pS.update(), pB.update());

    float a = atan2(pY.getDelta(), pX.getDelta()-1);

    pCurrSeg = frameCount % pNumSeg;
    pSeg[pCurrSeg].set(pX.getValue(), pY.getValue(), pHeight.getValue(), a, c);

    pCurrSeg += pNumSeg;

    for(int i=0; i<pNumSeg; i++) {
      int wh = (pCurrSeg - i) % pNumSeg;
      // trasform coordinates
      translate(pSeg[wh].x - i, pSeg[wh].y);

      float h = pSeg[wh].h;
      if (i < h/2) {
        h *= sqrt(1 - pow(1 - (i<<1) / h, 2));
      }

      rotate(pSeg[wh].a);
      // line
      noStroke();
      fill(pSeg[wh].c);
      rect(0, 0, 1, h);
      // highlight
      stroke(1, 0.3);
      point(0, h/2);
      // shadow
      stroke(0, 0.3);
      point(0, -h/2);
      // reset coordinates
      resetMatrix();
    }

  }
}

class Segment {
  float x = 0;
  float y = 0;
  float h = 0;
  float a = 0;
  color c = 0;

  Segment(float tX, float tY, float tH, float tA, color tC) {
    x = tX;
    y = tY;
    h = tH;
    a = tA;
    c = tC;
  }
  void set(float tX, float tY, float tH, float tA, color tC) {
    x = tX;
    y = tY;
    h = tH;
    a = tA;
    c = tC;
  }
}
