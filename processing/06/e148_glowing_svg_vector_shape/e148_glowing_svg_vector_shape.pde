PShape s;

void setup() {
  size(675, 675);
  colorMode(HSB);
  rectMode(CENTER);
  noStroke();
  println("click to glow!");
  s = loadShape("bla.svg");
}
void draw() {
  background(0);  
  for (int i=0; i<30; i++) {
    pushMatrix();
    translate(width/2, height/2);
    rotate(i);
    glowingShape(s, (i/10) * 20, (i%4) * 25, s.width, s.height, #55FF77, #228833, mousePressed);
    popMatrix();
  }
}
void glowingShape(PShape shp, float x, float y, float w, float h, color shapeColor, color glowColor, boolean effectOn) {
  shp.disableStyle();
  noFill();
  if (effectOn) {
    for (int i=0; i<5; i++) {
      strokeWeight((2+i)*(2+i));
      stroke(glowColor, 10);
      shape(shp, x, y, w, h);
    }
  }

  noStroke();
  fill(shapeColor);
  shape(shp, x, y, w, h);
}

