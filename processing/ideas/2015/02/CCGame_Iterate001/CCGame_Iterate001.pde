/* //<>//
 Q1. Aspect ratio.
 Q2. What are the main colors of the image? Orange, black.
 Q3. Is it more geometric or organic?
 Q4. How many areas of color are there?
 Q5. Are the edges broken or smooth?
 Q6. Are the surfaces noisy or smooth?
*/
PVector[] p;
void setup() {
  size(1200, 1200);
  colorMode(HSB, 100);
  noStroke();
  doit();
}
void draw() {
}
void keyPressed() {
  if(key == ' ') {
    doit();
  }
  if(key == 's') {
    save((System.currentTimeMillis() / 1000) + ".png");
  }
}
void doit() {
  background(7, 100, 70);
  p = new PVector[(int)random(5, 8)];
  for (int i=0; i<p.length; i++) {
    p[i] = new PVector(random(width*0.1, width*0.9), random(height*0.1, height*0.9));
  }
  int count = 1500;
  for (int i=0; i<count; i++) {
    color c;
    PVector pc = new PVector(random(width), random(height));
    boolean near = false;
    for (int j=0; j<p.length; j++) {
      if (pc.dist(p[j]) < width/(5+j*2)) {        
        near = true;        
        break;
      }
    }
    if (!near) {
      c = color(7, 100, 20 + 100 * noise(pc.x * 0.003, pc.y * 0.003));
    } else {
      c = color(7, random(20, 40), 10 + 18 * noise(pc.x * 0.006, pc.y * 0.006));
    }
    fill(c);
    float norm = map(i, 0, count, 1, 0);
    norm *= norm;
    myShape(pc.x, pc.y, map(norm, 1, 0, width/5, 6));
  }

  blendMode(ADD);
  fill(5);
  myFilter();

  blendMode(BLEND);
  fill(0, 10);
  myFilter();
}
void myFilter() {
  for (int i=0; i<15000; i++) {
    float x = random(width);
    float y = random(height);
    color c = get((int)x, (int)y);
    float r = random(1, 3);
    ellipse(x, y, r, r);
  }
}
void myShape(float x, float y, float r) {
  beginShape();
  for (float a=0; a<TAU; a+=0.01) { 
    float r2 = r * noise(x*0.2, y*0.2, a * 0.8);
    float a2 = a + sin(r2 * 0.1);
    vertex(x + r2 * cos(a2), y + r2 * sin(a2));
  }
  endShape();
}
