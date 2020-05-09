int Segments = 11;
PImage a;

// here we store all the curve points
float x[] = new float[Segments];
float y[] = new float[Segments];

// current blob location
float currentx;
float currenty;

void setup() {
  size(500, 500, P3D);
  smooth();
  noStroke();
  // start at the center of the screen
  currentx = width / 2;
  currenty = height / 2;
  a = loadImage("117555.png");
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
  texture(a);
  for (int i=0; i<Segments; i++) {
    vertex(x[i % Segments], y[i % Segments], 
      100 * noise(x[i % Segments] * 0.03), 
      100 * noise(y[i % Segments] * 0.03));
  }
  endShape();
}

void keyPressed() {
  if (key =='s') { 
    save("thumb.jpg"); 
    println("saved!");
  }
}
