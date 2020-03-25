/*
 Simple rings made out of circles.
 A better idea would be using a PShape and adding vertices.
 I wonder if that can also be done with translate() and rotate()
 by tilting flat rings.
 */
Ring a, b, c; 
int delay = 100;
void setup() {
  size(400, 400);
  noStroke();
  colorMode(HSB);
  background(0);
  a = new Ring(0, 50, 100, 50, #FFFF00);
  b = new Ring(TWO_PI / 3, 50, 100, 50, #FF00FF);
  c = new Ring(2 * TWO_PI / 3, 50, 100, 50, #00FFFF);
}
void draw() {
  float an = frameCount * 0.01;

  if (an < PI) { 
    a.draw(an);
    b.draw(an);
    c.draw(an);

    an += PI;
    a.draw(an);
    b.draw(an);
    c.draw(an);
  } 
  else {
    if(--delay > 0) {      
      return;
    }    
    /*
    PImage i = get();
    filter(BLUR, 8);
    blendMode(ADD);
    image(i, 0, 0);
    noLoop();
    */
    filter(ERODE);
    filter(BLUR, 2);
    filter(POSTERIZE, 2);
  }
}
void keyPressed() {
  if(key == 's') {
    save("thumb.jpg");
  }
}
class Ring {
  float angle, dist, radius, wi;
  int c;
  Ring(float angle, float dist, float radius, float wi, int c) {
    this.angle = angle;
    this.dist = dist;
    this.radius = radius;
    this.wi = wi;
    this.c = c;
  }
  void draw(float ang) {
    fill(c);
    pushMatrix();
    translate(width/2, height/2);
    rotate(angle);
    translate(dist, 0);
    rotate(ang);
    ellipse(radius, 0, wi, wi);
    popMatrix();
  }
}
