Cube c1;
Cube c2;
Cube c3;
    
void setup() {
  size(640, 360, P3D);
  noStroke();
  c1 = new Cube(50, 15, 0, #B6F0B1);
  c2 = new Cube(60, 12, -100, #F0E2B1);
  c3 = new Cube(80, 20, -200, #B1CFF0);
}

void draw() {
  background(240);  
  camera(width/2.0  + 300*cos(frameCount/300.0), height/2.0-100, height/2.0 + 300*sin(frameCount/300.0), width/2.0, height/2.0, 0, 0, 1, 0);
  lights();
  c1.draw();
  c2.draw();
  c3.draw();  
}

