// Note: this program runs only in the Processing IDE, not in the browser

import processing.video.*;

String PATH = "/path/to/one/of/your/movies/blabla.mp4";
Movie mov;

void setup() {
  size(640, 360);
  frameRate(30);
  mov = new Movie(this, PATH);
  mov.play();
  mov.speed(1);
  mov.volume(1);
  colorMode(HSB, 1);
  background(1);
  noStroke();
}

// This function is required. It takes care of preparing
// video frames for us as they arrive from the movie.
void movieEvent(Movie m) {
  m.read();
}

void draw() {
  // Before accessing the pixels array always use loadPixels!
  mov.loadPixels();
  
  // For each frame we draw a collection of dots
  // beginning at the center of the screen.

  int x = width/2;
  int y = height/2;

  // We draw up to 100 dots (less if we touch the border of
  // the screen while moving in this loop).

  for(int i=0; i<100; i++) {

    // Read the color of a pixels.
    // This is equivalent to mov.get(x*2, y*2);

    int c = mov.pixels[y*2*width+x*2];

    // Extract hue, saturation and brightness information from that color.

    float h = hue(c);
    float s = saturation(c);
    float b = brightness(c);

    // Draw an ellipse using that hue, saturation and brightness.

    fill(h, s, b);

    // The saturation sets the size of the ellipse.
    // We multiply the s variable because otherwise the maximum size
    // would be just 1 pixel.

    ellipse(x, y, s*20, s*20);

    // Now we take a step away from our position.
    // The size of this step depends on the brightness of the pixel.
    // We multiply b to allow for bigger steps, otherwise steps would be tiny.
    // In which direction we go (North, South, East, West, or something in
    // between) depends on the hue. We multiply also h to make it more
    // responsive to hue changes.

    x += sin(h*15) * b * 40;
    y += cos(h*15) * b * 40;

    // Finally, check if we touched a border while moving. If we did,
    // get out of the loop. There's no point in drawing out of the screen.
    if(x<0 || y<0 || x >= width || y>= height) {
      break;
    }
  }
  //This was how we displayed the video as normal video.
  //image(mov, 0, 0, width, height);
}

// Press a key to save the current image
void keyPressed() {
  saveFrame();
}
