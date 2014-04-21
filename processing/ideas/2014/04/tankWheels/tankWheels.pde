/*
  Robot wheels experiment.
  
  Quick hack with few calculations and lots of translate() and rotate().
  
  I should try a more precise approach, in which I can call
  drawTank(x, y, width, height, boxSize, boxSeparation);
  This better approach would calculate the full length of the track,
  divide it by (boxSize + boxSeparation) to get the amount of boxes.
  The distance between the boxes should be maintained while they move.
  
  Currently, boxes may move faster or slower when moving straight or turning,
  and there are too many arguments to be able to predict the result.
*/

void setup() {
  size(500, 500);
  rectMode(CENTER);
  noStroke();
}
void draw() {
  background(#FFCD85);

  fill(0, 50);
  drawTank(20, 70, 10, 3, 12, (frameCount % 30) / 30.0);  

  fill(0, 60);
  drawTank(30, 90, 20, 4, 6, (frameCount % 30) / 30.0);  

  fill(0, 70);
  drawTank(50, 120, 30, 4, 7, (frameCount % 30) / 30.0);  
}
void drawTank(float sep, float rad, float sz, int hUnits, int curveUnits, float time) {
  pushMatrix();
  float rot = PI / curveUnits;
  
  translate(width/2 - sep * hUnits / 2, height/2);
  for(int x=0; x<hUnits; x++) {
    rect(time * sep, -rad, sz, sz);
    translate(sep, 0);
  }
  rotate(time * rot);
  for(int a=1; a<curveUnits; a++) {  
    rect(0, -rad, sz, sz);  
    rotate(rot);
  }  
  rect(0, -rad, sz, sz);
  rotate((1-time) * rot);
  for(int x=0; x<hUnits; x++) {
    rect(time * sep, -rad, sz, sz);
    translate(sep, 0);
  }
  rotate(time * rot);
  for(int a=1; a<curveUnits; a++) {  
    rect(0, -rad, sz, sz);  
    rotate(rot);
  }    
  rect(0, -rad, sz, sz);
  popMatrix();
  if(frameCount < 31) {
    //saveFrame("/tmp/a/out##.gif");
  }  
}

