import toxi.math.noise.SimplexNoise;

/*
 * Smooth transitions for a grid of items
 * Avoid all items travelling simultaneously
 */
class EnvelopeGrid {
  private float val0, val1;
  private float timeF;
  private float timeOverlap = 0.3;
  private float balance = 0.5;
  private float noiseOffset;
  private long time0, time1;
  private boolean before, after = true;

  public EnvelopeGrid(float v) {
    val0 = v;
    val1 = v;
    time0 = time1 = System.currentTimeMillis();
  }

  public void animateTo(float targetVal, long dur_ms, long delay_ms) {
    if (after) {
      time0 = System.currentTimeMillis() + delay_ms;
      time1 = time0 + dur_ms;
      val1 = targetVal;
      noiseOffset = random(1000);
      updateTime();
    }
  }

  public boolean updateTime() {
    long timeCurr = System.currentTimeMillis();

    before = timeCurr < time0;
    after = timeCurr > time1;
    if (time0 != time1) {
      timeF = (timeCurr - time0) / (float)(time1 - time0);
    } else {
      timeF = 0.0f;
    }
    if (after) {
      val0 = val1;
      timeF = 0.0f;
    }
    return after; // done?
  }

  public float get(float xNorm, float yNorm) {
    // calculate a time based on xNorm and yNorm
    // then return the value for that time
    if (before) {
      return val0;
    }
    if (after) {
      return val1;
    }
    // convert xNorm and yNorm into a normalized float. would be nice to
    // find a way using noise
    //float start = (xNorm * balance + yNorm * (1-balance)) * (1 - timeOverlap);
    float start = (0.5f + 0.5f * (float)SimplexNoise.noise(xNorm, yNorm, noiseOffset)) * (1 - timeOverlap);
    float nuTime = constrain(norm(timeF, start, start + timeOverlap), 0, 1);
    return PApplet.map(easeInOut(nuTime), 0, 1, val0, val1);
  }
  
  public void setOverlap(float overlap) {
    timeOverlap = overlap;
  }
  
  public void setBalance(float b) {
    balance = b;
  }

  float easeInOut(float t) {
    t *= 2;
    if (t < 1) {
      return (t*t)/2;
    } else {
      t = 2 - t;
      return 1-(t*t)/2;
    }
  }

  // http://www.flong.com/texts/code/shapers_exp/
  private float bend(float x, float thr) {
    float a = 10;
    if (x <= thr) {
      return (float) Math.pow(x / thr, a) * thr;
    } else {
      return 1 - (float) Math.pow((1 - x) / (1 - thr), a) * (1 - thr);
    }
  }
}
