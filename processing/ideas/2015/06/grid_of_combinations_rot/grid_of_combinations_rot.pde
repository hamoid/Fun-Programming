// declare and initialize array in one line
int[] colors = { 
  #542437, #C02942, #D95B43, #ECD078
};
int[] sizes = { 
  6, 12, 18, 24
};
float[] rotations = {
  PI/2, -PI/2, PI, -PI
};

void setup() {
  size(550, 550);
  noStroke();
  rectMode(CENTER);

  drawIt();
}
void draw() {
}
void keyPressed() {
  if(key == ' ') {
    drawIt();
  }
}
void drawIt() {
  background(#53777A);

  noiseSeed(frameCount);
  randomSeed(frameCount);
  doit();
  filter(BLUR, 4);

  noiseSeed(frameCount);
  randomSeed(frameCount);
  doit();

  save("grid_of_combinations_rot.png");
}
void doit() {
  for (int x=60; x<width-60; x=x+60) {
    for (int y=60; y<height-60; y=y+60) {
      
      int whichRot = (int) (10 * noise(x*0.001,y*0.001));
      float a = rotations[whichRot % rotations.length];

      for (int repetitions=0; repetitions<4; repetitions=repetitions+1) {
        pushMatrix();
        translate(x, y);
        rotate(x * 0.00003 + y * 0.00003 - 0.02);

        int whichColor = (int) random(colors.length);
        fill(colors[whichColor]);

        int whichRadius = (int) random(sizes.length);
        float radius = sizes[whichRadius];
        
        float aa = a + (random(100) < 50 ? PI : 0);
        
        triangle(radius * cos(aa), radius * sin(aa),
          radius * cos(aa + TAU/3), radius * sin(aa + TAU/3),
          radius * cos(aa + 2*TAU/3), radius * sin(aa + 2*TAU/3));

        popMatrix();
      }
    }
  }
}
