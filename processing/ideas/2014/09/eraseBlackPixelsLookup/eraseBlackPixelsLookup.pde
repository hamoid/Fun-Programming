import java.util.*;

// Program that replaces black pixels
// with closest non black pixels.

// The condition can be easily replaced by another one:
// look for dark pixels, or saturated ones, for instance.

// Uses a lookup table of pixels sorted by distance.
// This allows searching for pixels, beginning with the immediate
// neighbors and then looking further out, without ever looking
// twice at the same pixel.

PVector[] pixelToCheck;

void setup() { 
  // draw background image
  image(loadImage("wood.jpg"), 0, 0);
  
  // draw black test graphics
  fill(0);
  stroke(0);
  noSmooth();
  text("click\nto\nerase\nblack\npixels", 20, 20);
  strokeWeight(8);
  noFill();
  ellipse(100, 100, 70, 70);

  buildLookupTable(100, 0);
  
  println("This is the beginning of the lookup table [x, y, distance]");
  for(int i=0; i<15; i++) {
    println(pixelToCheck[i]);
  }
  println("...");
}

// click to erase black pixels
void mousePressed() {
  int black = color(0);
  
  // Create a copy of the image.
  // Always read from the original and write to the copy.
  // This avoids reading colors from already modified pixels
  // which gives strange results
  PImage imageCopy = get();
  imageCopy.loadPixels();
  
  loadPixels();
main:
  for (int i=0; i<pixels.length; i++) {
    if (pixels[i] == black) {
      for (int j=1; j<pixelToCheck.length; j++) {
        int x = (int)(pixelToCheck[j].x);
        int y = (int)(pixelToCheck[j].y);
        int pixelId = i + x + width * y;
        if (pixelId >= 0 && pixelId < pixels.length && pixels[pixelId] != black) {
          imageCopy.pixels[i] = pixels[pixelId];
          continue main;
        }
      }
    }
  }
  imageCopy.updatePixels();
  image(imageCopy, 0, 0);
}

void draw() {
}

// side is the width and height of the lookup table.
// 100 would create a 100 x 100 table, so it would
// scan from -50 px to +50 px around a black pixel.

// randomness: good values can be between 0 and 5.
// Using a value greater than 0 can avoid the result 
// looking digital / pixelated.

void buildLookupTable(int side, float randomness) {
  int mid = side / 2;
  pixelToCheck = new PVector[side*side];
  for (int i=0; i<pixelToCheck.length; i++) {
    int x = i%side - mid;
    int y = i/side - mid;
    float d = dist(x, y, 0, 0) + random(randomness);
    // store distance to middle as z value
    pixelToCheck[i] = new PVector(x, y, d);
  }
  // sort by z (= by distance)
  Arrays.sort(pixelToCheck, new Comparator<PVector>() {
    @Override public int compare(PVector a, PVector b) {
      if (b.z == a.z) return 0;
      return a.z > b.z ? 1 : -1;
    }
  }
  );
}

