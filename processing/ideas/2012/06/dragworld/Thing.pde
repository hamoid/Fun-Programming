class Thing {
  float x;
  float y;
  float ax;
  float ay;
  float maxSz;
  float[] sizes = new float[int(random(1, 10))];

  Thing(float x, float y, float maxSz) {
    this.x = x;
    this.y = y;
    this.maxSz = maxSz;

    for(int i=0; i<sizes.length; i++) {
      sizes[i] = random(1);      
    }
    sizes[0] = 1.0;
    sizes = reverse(sort(sizes));
  }
  void setVector(float x, float y) {
    ax = x;
    ay = y;
  }
  void draw(int i) {
    if(i < sizes.length) { 
      float d = (1-sizes[i])*0.2+0.8;
      float s = sizes[i] * maxSz;      

      float hx = x-totDeltaX;
      float hy = y-totDeltaY;
      float hu = (noise(s/110, hx/666, hy/666) * 4) % 1;
      float sa = noise(hu*4 + hy/668, hx/668) * 1.2 - 0.2;
      float br = noise(hu*7 + hy/670, hx/670);
      fill(color(hu, sa, br));

      ellipse(CX+ax*d, CY+ay*d, s, s);
    }
  }
  void checkLimits(float x, float y) {
    if(x > width+margin) {
      this.x -= width+margin*2;
    } else if(x < -margin) {
      this.x += width+margin*2;
    }
    if(y > height+margin) {
      this.y -= height+margin*2;
    } else if(y < -margin) {
      this.y += height+margin*2;
    }
  }
  void move(int x, int y) {
    this.x += x;
    this.y += y;
  }
}
