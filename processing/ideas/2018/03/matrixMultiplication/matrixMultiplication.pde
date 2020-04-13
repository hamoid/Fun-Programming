// This program creates 3 square matrices. The first two ar populated with
// random numbers. The third one is the result of the matrix multiplication
// of the first two. Numbers are represented with colored subdivided squares.
// A 4 has 4 tiles. A 5 has 5 tiles: 3 tilesin one row and two in another.
// The sketch does not try to be useful, it's just an experiment.
int sz = 7;
int dim = 550;
int margin = 10;
int maxNum = 5; // Populate matrices with random numbers up to this value. Small = good. 
int[][] matA = new int[sz][sz];
int[][] matB = new int[sz][sz];
int[][] matC = new int[sz][sz];
PGraphics bg;
int framesToSave = 0;
void settings() {
  size(dim * 3 + margin * 4, dim + margin * 2);
}
void setup() {
  bg = createGraphics(width, height);
}
// Draw a square that represents a number
void drawSq(float x, float y, float sqsz, int num) {
  float sq = sqrt(num);
  int cols = floor(sq);
  int rows = ceil(sq);
  int a = max(cols, rows);
  int b = min(cols, rows);
  for (int j=0; j<b; j++) {
    if (j == b-1) {
      a = num - j * a;
    }
    for (int i=0; i<a; i++) {
      bg.fill((((i + j) * num) % 3) * 85 + 35, 
        ((i * 5 + j * 3 + num * 2) % 3) * 80 + 80, 
        ((i * num + j) % 2) * 50 + 200);
      bg.rect(x + i * sqsz/a, 
        y + j * sqsz/b, 
        sqsz/a, sqsz/b);
    }
  }
}

void draw() {
  image(bg, 0, 0);
  int n = (frameCount) % (sz * sz);
  int i = n / sz;
  int j = n % sz;
  stroke(255);
  noFill();
  strokeWeight(3);
  int y = i * dim / sz;
  int x = j * dim / sz;
  rect(margin, y + margin, dim - 2, dim / sz - 1);
  rect(margin * 2 + dim + x, margin, dim / sz - 1, dim - 2);
  rect(margin * 3 + dim * 2 + x, margin + y, dim / sz - 1, dim / sz - 1);
  if (framesToSave > 0) {
    save("/tmp/gif/" + nf(sz*sz-framesToSave, 2) + ".png");
    framesToSave--;
  }
}
void doit() {
  bg.beginDraw();
  bg.background(0);
  bg.stroke(0);
  bg.colorMode(HSB);
  for (int i=0; i<sz; i++) {
    for (int j=0; j<sz; j++) {
      matA[i][j] = (int)random(maxNum);
      matB[i][j] = (int)random(maxNum);
    }
  }
  for (int i=0; i<sz; i++) {
    for (int j=0; j<sz; j++) {
      matC[i][j] = 0;
      for (int k=0; k<sz; k++) {
        matC[i][j] += matA[i][k] * matB[k][j];
      }

      float x = map(j, 0, sz, 0, dim) + margin;
      float y = map(i, 0, sz, 0, dim) + margin;
      drawSq(x + (dim + margin) * 0, y, dim/sz-1, matA[i][j]); 
      drawSq(x + (dim + margin) * 1, y, dim/sz-1, matB[i][j]);
      drawSq(x + (dim + margin) * 2, y, dim/sz-1, matC[i][j]);
    }
  }
  bg.endDraw();
}
void keyPressed() {
  if (key == ' ') {
    doit();
  }
  if (key == 's') {
    framesToSave = sz * sz;
  }
}
