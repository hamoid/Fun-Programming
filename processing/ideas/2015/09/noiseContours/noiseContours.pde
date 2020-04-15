// Uses the openCV library from 
// https://github.com/cansik/opencv-processing/releases

import gab.opencv.*;
import java.util.Comparator;

ArrayList<Contour> contoursA, contoursB;

public class ByArea implements Comparator<Contour> {
  @Override
    public int compare(Contour a, Contour b) {
    return (int)(b.area() - a.area());
  }
}
void setup() {
  fullScreen();
  smooth();
  colorMode(HSB);
  int white = color(255);
  float zoom = 0.003;

  // Take 1 (odd bands)
  background(0);
  for (int x=0; x<width; x++) {
    for (int y=0; y<height; y++) {
      int n = (int)(300 * noise(x * zoom, y * zoom));
      if (n % 16 < 8) {
        set(x, y, white);
      }
    }
  }
  PImage src = get();
  OpenCV opencv = new OpenCV(this, src);
  contoursA = opencv.findContours();

  // Take 2 (even bands)
  filter(INVERT);
  // I use dilate because it seems opencv traces contours on the inside
  // of white areas, not on the middle between black and white areas.
  // This leads to areas slightly smaller than expected which do not
  // perfectly cover all the existing space.
  filter(DILATE);
  src = get();
  opencv = new OpenCV(this, src);
  contoursB = opencv.findContours();

  // Add take 2 to take 1.
  contoursA.addAll(contoursB);

  // find min/max area (optional, may be useful for mapping to colors)
  float minArea = Float.MAX_VALUE, maxArea = Float.MIN_VALUE;
  for (Contour contour : contoursA) {
    float area = sqrt(contour.area());
    if (area < minArea) {
      minArea = area;
    }
    if (area > maxArea) {
      maxArea = area;
    }
  }  

  background(0);
  stroke(0, 50);
  // Sort contours, so we draw large first, then small.
  // By default the order is random, and large areas sometimes cover small areas.
  contoursA.sort(new ByArea());
  for (Contour contour : contoursA) {
    float a = norm(sqrt(contour.area()), minArea, maxArea);
    fill(30 + a * 150, 255, 255 - 100 * a);
    contour.draw();
  }
}
void draw() {
}
void keyPressed() {
  if (key =='s') { 
    save("thumb.png"); 
    println("saved!");
  }
}
