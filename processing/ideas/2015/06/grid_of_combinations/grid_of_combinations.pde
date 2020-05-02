// declare and initialize array in one line
int[] colors = { 
  #91C38E, #66AB8C, #455964, #F8D583
};
int[] sizes = { 
  5, 10, 20, 40
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
  drawIt();
}
void drawIt() {
  background(#54415D);

  randomSeed(frameCount);
  doit();
  filter(BLUR, 4);

  randomSeed(frameCount);
  doit();

  save("grid_of_combinations.png");
}
void doit() {
  for (int x=60; x<width-60; x=x+60) {
    for (int y=60; y<height-60; y=y+60) {
      for (int repetitions=0; repetitions<4; repetitions=repetitions+1) {
        pushMatrix();
        translate(x, y);
        rotate(x * 0.00003 + y * 0.00003 - 0.02);

        int whichColor = (int) random(colors.length);
        fill(colors[whichColor]);

        int whichSize;    
        whichSize = (int) random(sizes.length);
        int rectWidth = sizes[whichSize];
        whichSize = (int) random(sizes.length);
        int rectHeight = sizes[whichSize];

        rect(0, 0, rectWidth, rectHeight, 2, 2, 2, 2);

        popMatrix();
      }
    }
  }
}
