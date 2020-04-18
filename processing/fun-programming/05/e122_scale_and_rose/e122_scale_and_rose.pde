// NOTE: 
//   There seems to be a bug in
//   Processing.js running in the browser.
//   The scale() function, explained in
//   episode 122, causes unexpected
//   side effects.

//   You can do two things:
//   1) run the program in the Processing IDE
//   2) delete the lines with strokeWeight()
//      and scale(), then
//      replace      cos(k*t)  
//           by  200*cos(k*t)

float k = 2/7.0;

void setup() {
  size(400, 400);
  background(#129575);
  colorMode(HSB);
  strokeWeight(0.01);
}
void draw() {
  translate(width/2, height/2);
  scale(200, 200);
  float t = frameCount / 20.0;
  float x = cos(k*t) * sin(t);
  float y = cos(k*t) * cos(t); 
  stroke(255);
  line(0, 0, x, y);
}
