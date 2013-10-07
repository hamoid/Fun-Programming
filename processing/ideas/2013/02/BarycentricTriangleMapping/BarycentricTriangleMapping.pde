// Based on:
//   http://forum.processing.org/topic/find-point-in-a-triangle-with-uv-coordinate

// Note to self: 
//   Read about "Delaunay"
//   Try http://code.google.com/p/poly2tri/

Tri T1;
Tri T2;

void setup() {
  size(400, 400); 
  fill(0, 5);
  smooth();
  T1 = new Tri();
  T2 = new Tri();
  println("Click for new triangles");
}
void draw() {
  background(255);

  stroke(0, 200, 0);
  T1.draw();
  ellipse(mouseX, mouseY, 10, 10);
    
  stroke(200);
  T2.draw();  
  PVector P = T2.getXY(T1.getUV(new PVector(mouseX, mouseY)));
  ellipse(P.x, P.y, 10, 10);
}
void mousePressed() {
  T1 = new Tri();
  T2 = new Tri();
}
