import toxi.color.*;
import toxi.math.*;
import java.util.*;

PImage img;
PVector target[] = new PVector[4];
PVector curr[] = new PVector[4];
float time = 0;
void setup() {
  size(1000, 1000);
  noFill();
  img = loadImage("cambodia_street_shop.jpg");
  img.resize(width, height);
  background(0);
  for (int i=0; i<4; i++) {
    target[i] = new PVector(random(width), random(height));
    curr[i] = new PVector(random(width), random(height));
  }
}
void draw() {
  for (int i=0; i<50; i++) {
    time += 0.001;

    target[0] = PVector.fromAngle(time);
    target[0].mult(300);
    target[0].add(width/2, height/2);

    target[1] = getClosest(img, target[0], mouseX*.25);
    target[2] = getClosest(img, target[0], mouseX*.50);
    target[3] = getClosest(img, target[0], mouseX*.75);

    for(int j=0; j<4; j++) { 
      curr[j].lerp(target[j], 0.03);
    }
   
    bezier(
      curr[0].x, curr[0].y, 
      curr[1].x, curr[1].y, 
      curr[2].x, curr[2].y, 
      curr[3].x, curr[3].y);
  }
}
// For a given image i and point p, look around p at a given
// radius for the most similar color to i.pixels[@p].
// Set the stroke color to i.pixels[@p] with reduced alpha.
// return the pixel coordinates of that most-similar color.
PVector getClosest(PImage i, PVector p, float radius) {
  float pixelResolution = 1;
  float minDist = Float.MAX_VALUE;
  TColor c = TColor.newARGB(i.get((int)p.x, (int)p.y));
  c.setAlpha(0.05);
  stroke(c.toARGB());
  PVector vmin = new PVector();
  PVector test = new PVector();
  for (float a=0; a<TAU; a+=pixelResolution/radius) {
    test = PVector.fromAngle(a).mult(radius).add(p);
    TColor c2 = TColor.newARGB(i.get((int)test.x, (int)test.y));
    float d = c.distanceToRGB(c2);
    if (d < minDist) {
      minDist = d;
      vmin.set(test);
    }
  }
  return vmin;
}
void keyPressed() {
  if (key == ' ') {
    background(0);
  }
  if (key == 's') {
    save(System.currentTimeMillis() + ".png");
  }
}
