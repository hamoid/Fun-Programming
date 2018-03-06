/*
  Creative Code Jam - Berlin (Jan 2017)
  
  My results from the Copycat Game with @CreativeCodeBLN, 
  based on a verbal description of a gif loop.

  Three colors: dark gray, light gray, dirty white
  Sine wave animation
  Square canvas with a dark margin
  Dark background
  Lighter gray square.
  Height of the animation is the height of the inner box.
  The width is divided in 1, 2 and 1
  Regular sine wave, full height, dirty white.
  Some pixelation (3x3 with 2 px margin)
  Mountain sine wave.
  Direction scrolling to the left.
  Timing: about 3 seconds loop.
  Pixels become circles a bit larger 
  than the squares when on.
*/

color darkGray = #333333;
color lightGray = #555555;
color dirtyWhite = #E5E4DE;
int margin = 50;
int pixelSize = 15;
ArrayList<Pixel> myPixels;
void setup() {
  size(500, 500);
  rectMode(CENTER);
  noStroke();
  myPixels = new ArrayList<Pixel>();
  for (int x=margin; x<width-margin; x+=pixelSize) {
    for (int y=margin; y<height-margin; y+=pixelSize) {
      myPixels.add(new Pixel(x, y));
    }
  } 
}
void draw() {
  background(darkGray);
  for(Pixel p : myPixels) {
    float yThreshold = map(sin(p.x*0.03+millis() * 0.003), -1, 1, 1 * margin, height - 1 * margin);
    p.update(p.y > yThreshold && p.x > 150 && p.x < 350);
    p.draw();
  }
}