import java.util.Random;

int[] pixelOrder;
int index = 0;

int PIXELS_PER_FRAME = 5000;

void setup() { 
  size(200, 200, P2D);
}
void draw() {
  if (pixelOrder == null) {
    return;
  }
  loadPixels();
  for (int i=0; i<PIXELS_PER_FRAME; i++) {
    int c = pixels[pixelOrder[index]];
    int r = c >> 16 & 0xFF;
    int g = c >> 8 & 0xFF;
    int b = c & 0xFF;
    pixels[pixelOrder[index]] = (r!=0 ? r-1 : 0) << 16 | (g!=0 ? g-1 : 0) << 8 | (b!=0 ? b-1 : 0);
    if (index-- == 0) {
      index = pixelOrder.length - 1;
    }
  }
  updatePixels();
}
// NOTE: There are probably better patterns than purely random.
// Something between sequential and random.
// Because purely random creates antialiasing issues on
// high contrast areas.
void shuffleArray(int[] array) {
  int index, temp;
  Random random = new Random();
  for (int i = array.length - 1; i > 0; i--) {
    index = random.nextInt(i + 1);
    temp = array[index];
    array[index] = array[i];
    array[i] = temp;
  }
}
void mousePressed() {
  pixelOrder = new int[width*height];
  for (int i=0; i<pixelOrder.length; i++) {
    pixelOrder[i] = i;
  }
  shuffleArray(pixelOrder);

  background(255);
  noStroke();
  translate(width/2, height/2);
  for (int i=0; i<20; i++) {
    fill(random(255), random(255), random(255));
    rotate(random(TAU));
    rect(random(width/2), 0, random(width/2), 40);
  }
}
