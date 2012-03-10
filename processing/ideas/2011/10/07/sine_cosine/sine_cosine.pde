// Tool for demonstrating Sine and Cosine
// by Abe Pazos - http://funprogramming.org
float W2;
float H2;
boolean show_angles = true;
boolean running = true;

void setup() {
  size(500, 400);
  noFill();
  smooth();
  frameRate(15);
  W2 = width/2;
  H2 = height/2;
}
void draw() {
  background(255);
  strokeWeight(1);
  translate(W2, H2);

  // GRID
  textSize(12);
  fill(180);
  for (float x=-W2; x< W2; x=x+50) {
    if (x == 0) {
      stroke(100);
    } else {
      stroke(230);
    }
    line(x, -H2, x, H2);
    if (!show_angles) {
      text(nfp(x/100, 1, 1), 3+x, 15);
    }
  }
  for (float y=-H2; y< H2; y=y+50) {
    if (y == 0) {
      stroke(100);
    } else {
      stroke(230);
      if (!show_angles) {
        text(nfp(-y/100, 1, 1), -33, y-4);
      }
    }
    line(-W2, y, W2, y);
  }
  
  textSize(14);  
  if(show_angles) {
    text("180º = π", -172, 15);
    text("0º = 2π", 110, -4);
    text("90º = π/2", -78, -108);
    text("270º = 3π/2", 3, 115);
  }
  noFill();
  
  // Circle
  stroke(255, 0, 0);
  ellipse(0, 0, 200, 200);
  
  // Angle
  stroke(0, 0, 255);
  float a = atan2(mouseY-H2, mouseX-W2);
  float a2 = (a > 0 ? TWO_PI : 0) - a;
  float x = cos(a)*100;
  float y = sin(a)*100;
  strokeWeight(2);
  line(0, 0, x, y);
  line(0,0, 100, 0);
  noFill();
  arc(0, 0, 100, 100, -a2, 0);
  
  // Angle info
  fill(0, 0, 255);
  text(nf(a2, 1, 2) + " radians" + " = " 
    + nf(degrees(a2), 1, 2) + " degrees" 
    + " = " + nf(a2/PI, 1, 2) + " π", 20-W2, 25-H2);
    
  // Cosine
  strokeWeight(4);
  stroke(#FF9100);
  line(0, 0, x, 0);
  fill(#FF9100);
  text("cos(" + nf(a2, 1, 2) + ") = " + nfp(cos(a2), 1, 2), x, H2 - 30);
  
  // Sine
  stroke(#50BF02);
  line(x, 0, x, y);
  fill(#50BF02);  
  text("sin(" + nf(a2, 1, 2) + ") = " + nfp(sin(a2), 1, 2), 20-W2, y-4);

  // Point in curve
  stroke(0);
  ellipse(x, y, 4, 4);
  
  // Info
  textSize(11);
  fill(180);
  text("Click to toggle info, press a key for pause", 10, H2-10);
}
void mousePressed() {
 show_angles = !show_angles; 
}
void keyPressed() {
  running = !running;
  if (running) {
    loop();
  } else {
    noLoop();
  }
}
