// positions for our letters
PVector[] pos = new PVector[27];

void setup() {
  size(600, 600, P3D);
  
  // this seems to get rid of opaque 
  // backgrounds around the letters
  hint(DISABLE_DEPTH_TEST);

  // come up with random positions for each letter 
  for(int i=0; i<pos.length; i++) {
    pos[i] = PVector.random2D();
  }
  
  fill(0);
  textSize(100);
}
void draw() {
  background(255);
  for(int i=0; i<pos.length; i++) {
    pushMatrix();
    
    // put the origin horizontally in the middle of the screen,
    // vertically somewhere random around the center
    translate(width/2, map(pos[i].y, -1, 1, height*0.4, height*0.6));
    
    // slowly rotate, each letter gets its own rotation
    rotateY(frameCount * 0.01 + i);
    
    // write a letter
    float xDistance = map(pos[i].x, -1, 1, width*0.1, width*0.8);
    text(char(65+i), xDistance, 0);

    // undo calls to translate and rotate    
    popMatrix();
  }
}
void keyPressed() {
  if(key == 's') {
    saveFrame("####.tif");
  }
}
