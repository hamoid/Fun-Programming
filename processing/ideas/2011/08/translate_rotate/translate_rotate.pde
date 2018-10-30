boolean do_translate = false;
boolean do_rotate = false;
boolean do_scale = false;
boolean show_axes = true;

float theRot = 0;
int theRotStartX = 0;

int theTransX, theTransY;
int theTransStartX, theTransStartY;

float theScale = 1;
float theScaleStartX = 0;

void keyPressed() {
  if (key == 't') {
    if (do_translate) {
      do_translate = false;
      theTransX += mouseX - theTransStartX;
      theTransY += mouseY - theTransStartY;
    } else {
      do_translate = true;
      theTransStartX = mouseX;
      theTransStartY = mouseY;
    }
  }
  if (key == 'T') {
    theTransX = 0;
    theTransY = 0;
  }
  if (key == 'r') {
    if (do_rotate) {
      do_rotate = false;
      theRot += (theRotStartX - mouseX) * 0.01;
    } else {
      do_rotate = true;
      theRotStartX = mouseX;
    }
  }
  if (key == 'R') {
    theRot = 0;
  }
  if (key == 's') {
    if (do_scale) {
      do_scale = false;
      theScale += (mouseX - theScaleStartX) * 0.01;
      theScale = max(0.2, theScale);
    } else {
      do_scale = true;
      theScaleStartX = mouseX;
    }
  }
  if (key == 'S') {
    theScale = 1;
  }
  if (key == ' ') {
    show_axes = !show_axes;
  }
}


void setup() {
  size(600, 600);
  smooth();
  strokeWeight(2);
  textSize(15);
  println("press t, r, s to toggle translate, rotate, scale");
  println("press T, R, S to reset them");
  println("press space to toggle axes");
}
void draw() {
  background(255);

  int rectY = frameCount % 100;

  strokeWeight(1);
  stroke(100, 100, 255);
  fill(0, 30);
  rect(50, 50, 200, 200);

  fill(100, 100, 255);
  text("size(200,200);", 270, 70);
  fill(30);
  text("ellipse(0,0,100,50);", 270, 150);
  text("rect(130," + rectY + ",40,30);", 270, 170);

  int dX = do_translate ? mouseX - theTransStartX : 0;
  int dY = do_translate ? mouseY - theTransStartY : 0;
  float dRot = do_rotate ? (theRotStartX - mouseX) * 0.01 : 0; 
  float dScale = do_scale ? (mouseX - theScaleStartX) * 0.01 : 0; 

  int transCurrX = theTransX + dX;
  int transCurrY = theTransY + dY;
  float rotCurr = theRot + dRot;
  float scaleCurr = theScale + dScale;
  scaleCurr = max(0.2, scaleCurr);

  if (transCurrX == 0 && transCurrY == 0) {
    fill(130);
    text("//translate(0, 0);", 270, 90);
  } else {
    fill(30);
    text("translate(" + transCurrX + "," + transCurrY + ");", 270, 90);
  }

  if (rotCurr == 0) {
    fill(130);
    text("//rotate(" + nf(0, 1, 2) + ");", 270, 110);
  } else {
    fill(30);
    text("rotate(" + nf(rotCurr, 1, 2) + ");", 270, 110);
  }

  if (scaleCurr == 1) {
    fill(130);
    text("//scale(" + nf(0, 1, 2) + ");", 270, 130);
  } else {
    fill(30);
    text("scale(" + nf(scaleCurr, 1, 2) + ");", 270, 130);
  }

  translate(50, 50);
  translate(transCurrX, transCurrY);
  rotate(rotCurr);
  scale(scaleCurr);

  strokeWeight(1/scaleCurr);

  if (show_axes) {
    // y axis
    stroke(255, 0, 0);
    line(0, -600, 0, 600);
    fill(255, 0, 0);
    text("y", 10, 100);

    // x axis
    stroke(0, 200, 0);
    line(-600, 0, 600, 0);
    fill(0, 200, 0);
    text("x", 100, 10);

    // 0,0 ellipse
    stroke(100, 100, 255);
    noFill();
    ellipse(0, 0, 15, 15);

    // grid
    stroke(0, 2);
    for (int x=-600; x<=600; x+= 100) {
      for (int y=-600; y<=600; y+= 100) {
        line(x, -600, x, 600);
        line(-600, y, 600, y);
      }
    }
  }

  // ellipse + rect
  stroke(0);
  noFill();
  ellipse(0, 0, 100, 50);
  rect(130, rectY, 40, 30);
}
