/*
  Processing port of http://www.playfuljs.com/realistic-terrain-in-130-lines/
  by Jerome Herr and Abe Pazos
  
  v0.0.1 Simple translation http://pastebin.com/MzefraMq (2.5 fps)
  v0.0.2 Split TerrainP5 class in two: TerrainData and TerrainSimpleRender.
         This allows creating new rendering engines for the same data (using
         real 3D surfaces, for instance)
  v0.0.3 Speed optimizations in rendering, where most of the time is spent. (8 fps)
  v0.0.4 Drawing rect() with integers (fast mode) (12 fps)
*/

TerrainData terData;
TerrainSimpleRender terRender;

void setup() {
  size(900, 500);
  terData = new TerrainData(8);
  terRender = new TerrainSimpleRender(terData, false);  
  doit();
}
void draw() {
  //doit();
  //println(frameRate);
}
void doit() {
  background(#C1EDF2);
  terData.calculateHeights(0.7);
  terRender.draw();
}
void mousePressed() {
  doit();
}
void keyPressed() {
  if(key == 's') {
    saveFrame("####.jpg");
  }
}

