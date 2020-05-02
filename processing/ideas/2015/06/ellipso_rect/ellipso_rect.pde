int num = 240, dotsSide = num/4, spaceBetween = 5, counter, frames = 180, toSave = 0;
float x, y, radius, sz = 2;
PVector[] dotsRect = new PVector[num];
PVector[] dotsCircle = new PVector[num];
ArrayList<Particle> particles;

// Original code by Jerome Herr at
// http://p5art.tumblr.com/post/120693457458/ellipsorect-code

// Bouncy effect by aBe, using Penner's easing equation

void setup() {
  size(540, 540);
  background(0);
  noStroke();
  
  particles = new ArrayList<Particle>();
  
  for (int j=1; j<=4; j++) {
    for (int i=0; i<dotsSide; i++) {
      switch (j) {
      case 1:
        x = i*spaceBetween;
        y = 0;
        break;
      case 2:
        x = dotsSide*spaceBetween;
        y = i*spaceBetween;
        break;
      case 3:        
        x = dotsSide*spaceBetween - i*spaceBetween;
        y = dotsSide*spaceBetween;
        break;
      case 4:
        x = 0;
        y = dotsSide*spaceBetween - i*spaceBetween;
        break;
      }
      dotsRect[counter] = new PVector(x, y);
      counter++;
    }
  }
  radius = (dotsSide*spaceBetween)/2;
  for (int i=0; i<num; i++) {
    x = radius + cos(PI+PI/4+TWO_PI/num*i)*radius*.8;
    y = radius + sin(PI+PI/4+TWO_PI/num*i)*radius*.8;
    dotsCircle[i] = new PVector(x, y);
  }
}

void draw() {
  background(0);
  translate((width-2*radius)/2, (width-2*radius)/2);
  for (int i=0; i<num; i++) {
    float a = TWO_PI * i / num;
    float delta = 7 + 7 * cos(a);
    float t = (frameCount + delta) % frames;
    float lerpValue;
    if (t < frames * 0.25) {
      lerpValue = Bounce.easeOut(t, 0, 1, frames*0.25);
    } else if (t < frames * 0.5) {
      lerpValue = 1;
    } else if (t < frames * 0.75) {
      lerpValue = Bounce.easeOut(t-frames*0.5, 1, -1, frames*0.25);
    } else {
      lerpValue = 0;
    }
    PVector newV = PVector.lerp(dotsRect[i], dotsCircle[i], lerpValue);
    fill(255);
    ellipse(newV.x, newV.y, sz, sz);
    if((int)t == (int)(frames * 0.095)) {
      particles.add(new Particle(dotsRect[i], dotsCircle[i]));
    }
    if((int)t == (int)(frames * 0.595)) {
      particles.add(new Particle(dotsCircle[i], dotsRect[i]));
    }
  }
  for(int i=particles.size()-1; i>=0; i--) {
    Particle p = particles.get(i);
    p.draw();
    if(p.brightness < 1) {
      particles.remove(i);
    }
  }
  if(toSave > 0) {
    saveFrame("/tmp/a/frm#####.gif");
    println(--toSave);
  }
}
// https://github.com/jesusgollonet/processing-penner-easing
public static class Bounce {
  // time, beginning, change, duration
  public static float  easeOut(float t, float b, float c, float d) {
    if ((t/=d) < (1/2.75f)) {
      return c*(7.5625f*t*t) + b;
    } else if (t < (2/2.75f)) {
      return c*(7.5625f*(t-=(1.5f/2.75f))*t + .75f) + b;
    } else if (t < (2.5/2.75)) {
      return c*(7.5625f*(t-=(2.25f/2.75f))*t + .9375f) + b;
    } else {
      return c*(7.5625f*(t-=(2.625f/2.75f))*t + .984375f) + b;
    }
  }
}
void keyPressed() {
  if(key == 's') {
    toSave = frames;
  }
}
class Particle {
  PVector pos;
  float heading;
  float headingInc;
  float speed;
  float brightness;
  Particle(PVector from, PVector curr) {
    brightness = 255;
    speed = 3;
    pos = curr.copy();
    heading = atan2(curr.y-from.y, curr.x-from.x);
    headingInc = noise(curr.x * 0.02, curr.y * 0.02) - 0.5;
  }
  void draw() {
    fill(255, brightness);
    ellipse(pos.x, pos.y, 2, 2);
    if(brightness > 254) {
      blendMode(ADD);
      fill(90);
      ellipse(pos.x, pos.y, 15, 15);
      blendMode(BLEND);
    }
    PVector mov = PVector.fromAngle(heading);
    mov.mult(speed);
    pos.add(mov);
    brightness *= 0.95;
    heading += headingInc;
    speed *= 0.95;
  }
}
