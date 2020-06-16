class Particle {
  private PVector pos;
  private PVector dir;
  public boolean done;
  public boolean findSpot() {
    boolean found;
    do {
      found = true;
      pos = new PVector(random(40, width-40), random(40, height-40));
    outerloop:      
      for (float d=1; d<20; d++) {
        int oversampling = 4;
        for (int n = 0; n<d+oversampling; n++) {
          float a = random(TWO_PI);
          int x = (int)(pos.x + d * cos(a));
          int y = (int)(pos.y + d * sin(a));
          int i = x + y * width;
          if (pixels[i] != 0xFFFFFFFF) {            
            found = false;
            break outerloop;
          }
        }
      }
    } while (!found);

    dir = PVector.fromAngle(12 * noise(pos.x * 0.05, pos.y * 0.05));
    done = false;
    return true;
  }
  public PVector move() {
    if (!done) {
      float orientation = dir.heading();
      //PVector olddir = dir.copy();

      // Repel-non-white force
      for (float d=1; d<20; d*=1.1 ) {
        int oversampling = 4;
        for (int n = 0; n<d+oversampling; n++) {
          float a = orientation + random(-HALF_PI, HALF_PI);
          PVector force = PVector.fromAngle(a);
          force.mult(d);
          PVector tp = PVector.add(pos, force);
          int i = (int)tp.x + (int)tp.y * width;
          if (i < 0 || i >= pixels.length || pixels[i] != 0xFFFFFFFF) {
            force.setMag(0.5/pow(d, 1));
            dir.sub(force);
          }
          a = orientation + random(HALF_PI, HALF_PI * 1.5) * ((frameCount % 60) < 30 ? -1 : 1);
          force = PVector.fromAngle(a);
          force.mult(d*2);
          tp = PVector.add(pos, force);
          i = (int)tp.x + (int)tp.y * width;
          if (i < 0 || i >= pixels.length || pixels[i] != 0xFFFFFFFF) {
            force.setMag(0.1/pow(d, 1.2));
            dir.add(force);
          }
        }
      }
      // if force pointing to where we came from, or we're out of the screen
      //if ((PVector.dot(dir, olddir)) < -0.5 || pos.x < 0 || pos.x > width || pos.y < 0 || pos.y > height) {
      if (get((int)pos.x, (int)pos.y) != 0xFFFFFFFF) {
        done = true;
      } else {
        dir.setMag(3);
        pos.add(dir);
      }
    }
    return pos.copy();
  }
}