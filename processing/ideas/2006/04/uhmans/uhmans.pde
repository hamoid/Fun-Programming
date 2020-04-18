/*
  Abe Pazos - www.hamoid.com | www.314bits.com - 22.04.2006
  
  My third experiment with processing.
  Using array of objects with push and pop
  to create 'self' animated objects with
  a certain lifespan.
  
  (Updated to P3D)
*/

//import processing.opengl.*;

MElli e1;
MElli e2;
DropGlass DG;
float di;
float heatk;
boolean nice;

void setup() {
  fullScreen(P3D);
  e1 = new MElli();
  e2 = new MElli();
  DG = new DropGlass();
  nice = false;
  heatk = 1;
  smooth();
  background(0);
  //orientation(LANDSCAPE);
}

void draw() {
  pushMatrix();
  translate(width/2, height/2);
  rotateY(e1.x/500);
  rotateX(e2.x/500);
  e1.move();
  e2.move();
  di = dist(e1.x, e1.y, e2.x, e2.y);
  if (di < 150) {
    addHeat(e1, e2, heatk*di/2);
    heatk = heatk * 1.05;
  } else {
    heatk = 1;
  }
  if (di > 400) {
    if (nice == false) {
      DG.add(e1);
      DG.add(e2);
      nice = true;
    }
  } else {
    nice = false;
  }
  DG.update();
  popMatrix();
  
  hint(DISABLE_DEPTH_TEST);
  //translate(0,0,300);
  noStroke();
  blendMode(SUBTRACT);
  fill(1);
  rect(0, 0, width, height);
  blendMode(BLEND);
}

void addHeat(MElli o1, MElli o2, float w) {
    noStroke();
    fill(255,0,0, 50);
    ellipse((o1.x+o2.x)/2, (o1.y+o2.y)/2, w, w);  
}

class Drop {
  MElli target_o;
  float sz;
  
  Drop(MElli o) {
    target_o = o;
    sz = 1;
  }
  boolean wider() {
    sz = sz * 1.2;
    ellipse(target_o.x, target_o.y, sz, sz);
    return sz > width;
  }
}

class DropGlass {
  Drop[] drops;
  
  DropGlass(){
    drops = new Drop[0];
  }
  void add(MElli o) {
    Drop[] b = new Drop[drops.length+1];
    b[0] = new Drop(o);
    arrayCopy(drops, 0, b, 1, drops.length); 
    drops = b;
  }
  void remove() {
    Drop[] b = new Drop[drops.length-1];
    arrayCopy(drops, 1, b, 0, drops.length-1);
    drops = b;
  }  
  void update() {
    if (drops.length > 0) {
      noFill();
      strokeWeight(2);
      stroke(80,255,0, 100);
      int i=0;
      while (i<drops.length) {
        if(drops[i].wider()) {
          remove();
        }
        i++;
      }
    }
  }
}

class MElli {
  float x;
  float lastx;

  float y;
  float lasty;

  float speed;
  float angle;

  MElli() {
    x = random(0, width);
    lastx = x;

    y = random(0, height);
    lasty = y;

    angle = random(-PI, PI);
    speed = random(0, 10);
  }

  void move() {
    angle = angle + random(-0.5, 0.5);
    speed = constrain(speed + random(-0.5, 0.5), 0, 10);
    x = x + speed * sin(angle);
    y = y + speed * cos(angle);
    if (x > width/2) {
      x = -width/2;
      lastx = x;
    }
    if (y > height/2) {
      y = -height/2;
      lasty = y;
    }
    if (y < -height/2) {
      y = height/2;
      lasty = y;
    }
    if (x < -width/2) {
      x = width/2;
      lastx = x;
    }
    //strokeWeight(5+speed);
    stroke(255);
    line(lastx, lasty, x,y);
    lastx = x;
    lasty = y;
  }
}
