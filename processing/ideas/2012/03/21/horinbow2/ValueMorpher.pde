class ValueMorpher {
  float pMin;
  float pMax;

  float pFrom;
  float pTo;
  float pCurr;

  float pT = 0;
  float pDelta = 0;

  float pChProb;
  float pRate;

  ValueMorpher(float tMin, float tMax, float tRate, float tChProb) {
    pMin = tMin;
    pMax = tMax;

    pChProb = tChProb;
    pRate = tRate;

    reset();
    pCurr = pFrom = pTo;
  }

  float update() {
    if (pT > 0) {
      pT -= pRate;
      if (pT > 0) {
        float n = 1-pT; // 0 .. 1
        float ease = (n /= 0.5) < 1 ? 0.5 * pow(n, 2) : -0.5 * ((n -= 2)*n - 2);
        pDelta = pCurr;
        pCurr = lerp(pFrom, pTo, ease);
        pDelta -= pCurr;
      }
      else {
        pFrom = pCurr;
      }
    }
    else {
      if (random(1) < pChProb) {
        reset();
        pT = 1;
      }
    }
    return pCurr;
  }
  void reset() {
    pTo = random(pMin, pMax);
  }
  float getValue() {
    return pCurr;
  }
  float getDelta() {
    return pDelta;
  }
}