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
void settings() {
  size(dim * 3 + margin * 4, dim + margin * 2);
}
void setup() {
  background(0);
  stroke(0, 30);
  colorMode(HSB);
  for (int i=0; i<sz; i++) {
    for (int j=0; j<sz; j++) {
      matA[i][j] = (int)random(maxNum);
      matB[i][j] = (int)random(maxNum);
    }
  }
  for (int i=0; i<sz; i++) {
    for (int j=0; j<sz; j++) {
      matC[i][j] = 0;
      for(int k=0; k<sz; k++) {
        matC[i][j] += matA[i][k] * matB[k][j];
      }
      
      float x = map(j, 0, sz, 0, dim) + margin;
      float y = map(i, 0, sz, 0, dim) + margin;
      drawSq(x + (dim + margin) * 0, y, dim/sz-1, matA[i][j]); 
      drawSq(x + (dim + margin) * 1, y, dim/sz-1, matB[i][j]);
      drawSq(x + (dim + margin) * 2, y, dim/sz-1, matC[i][j]);
    }
  }
}
// Draw a square that represents a number
void drawSq(float x, float y, float sqsz, int num) {
  float sq = sqrt(num);
  int cols = floor(sq);
  int rows = ceil(sq);
  int a = max(cols, rows);
  int b = min(cols, rows);
  for (int j=0; j<b; j++) {
    if(j == b-1) {
      a = num - j * a;
    }
    for (int i=0; i<a; i++) {
      fill(((i + j) * num * 13) % 256, 
           (57 + i * 42 + j * 55) % 256, 
           ((170 + 93 * num * i * j) % 200) + 56);
      rect(x + i * sqsz/a, 
           y + j * sqsz/b, 
           sqsz/a, sqsz/b);
    }
  }
}

void draw() {
}
