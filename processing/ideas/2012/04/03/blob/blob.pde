// In this sketch I test curveVertex
// Notice that three Vertices are drawn twice to make it a closed shape.
 
int Segments = 11;
 
// here we store all the curve points
float x[] = new float[Segments];
float y[] = new float[Segments];
 
// current blob location
float currentx;
float currenty;
 
void setup() {
  size(500, 500);
  smooth();
  noStroke();
  // start at the center of the screen
  currentx = width / 2;
  currenty = height / 2;
}
void draw() {
  background(#E3C830);
  
  // move a little bit from where we are
  // towards the mouse
  currentx = lerp(currentx, mouseX, 0.02);
  currenty = lerp(currenty, mouseY, 0.02);
  
  // calculate all the points.
  // they are laid out in a radial fashion, like
  // the hours in a clock.
  // the distance from the center is random and depends
  // on the current frameCount.
  for (int i=0; i<Segments; i++) {
    float angle = float(i) / float(Segments) * TWO_PI;
    float distance = 20 + 180 * noise(i, frameCount/20.0);        
    x[i] = currentx + sin(angle) * distance;
    y[i] = currenty + cos(angle) * distance;
  }
 
  // draw the blob  
  beginShape();
  for (int i=0; i<Segments+3; i++) {
    curveVertex(x[i % Segments], y[i % Segments]);
  }
  endShape();
}
