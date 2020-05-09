class Flood {
  int stackSize = width*height;
  int[] stack = new int[stackSize];
  int stackPointer;
  int threshold;

  Point pop() { 
    if (stackPointer > 0) { 
      int p = stack[stackPointer]; 
      stackPointer--; 
      return new Point(p / height, p % height);
    } else { 
      return null;
    }
  }    

  void push(int x, int y) {
    if(stackPointer < stackSize - 1 && x >= 0 && x < width) {
      stackPointer++; 
      stack[stackPointer] = height * x + y;
    }
  }     

  void emptyStack() { 
    while (pop () != null);
  }
  int cdist(int c1, int c2) {
    int rmean = ( (c1 >> 16 & 0xFF) + (c2 >> 8 & 0xFF) )/2;
    int r = (c1 >> 16 & 0xFF) - (c2 >> 8 & 0xFF);
    int g = (c1 >> 8 & 0xFF) - (c2 >> 8 & 0xFF);
    int b = (c1 & 0xFF) - (c2 & 0xFF);
    int weightR = 512 + rmean;
    int weightG = 1024;
    int weightB = 512 + 255-rmean;
    return weightR*r*r + weightG*g*g + weightB*b*b;
  }
  boolean isSimilar(int colorA, int colorB) {
    return cdist(colorA, colorB) < threshold; 
  }
  Flood(int x, int y, int newColor, int oldColor, int threshold) {
    this.threshold = threshold;
    loadPixels();

    if (oldColor == newColor) return;
    emptyStack();

    int y1; 
    boolean spanLeft, spanRight;

    push(x, y);
    Point po;

    while ( (po = pop ()) != null) {    
      y1 = po.y;
      while (y1 >= 0 && isSimilar (pixels[po.x + width * y1], oldColor)) y1--;

      y1++;
      spanLeft = spanRight = false;
      while (y1 < height && isSimilar(pixels[po.x + width * y1], oldColor)) {
        pixels[po.x + width * y1] = newColor;

        if (!spanLeft && po.x > 0 && isSimilar(pixels[po.x - 1 + width * y1], oldColor)) {
          push(po.x - 1, y1);
          spanLeft = true;
        } else if (spanLeft && po.x > 0 && !isSimilar(pixels[po.x - 1 + width * y1], oldColor)) {
          spanLeft = false;
        }

        if (!spanRight && x < width - 1 && isSimilar(pixels[po.x + 1 + width * y1], oldColor)) {
          push(po.x + 1, y1);
          spanRight = true;
        } else if (spanRight && po.x < width - 1 && !isSimilar(pixels[po.x + 1 + width * y1], oldColor)) {
          spanRight = false;
        } 
        y1++;
      }
    }
    updatePixels();
  }
}
class Point {
  int x, y;
  Point(int x, int y) {
    this.x = x;
    this.y = y;
  }
}
