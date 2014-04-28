void setup() {
  size(400, 400, P2D);
  background(0);
  smooth();
  colorMode(HSB, 1.0);
  frameRate(150);
}
void draw() {
  for(int i=0; i<10; i++) {    
    float x = random(width);
    float y = random(height);
  
    float H = noise(x/300, y/300);
    float B = noise(x/50, y/50);
    stroke(H, 0.9, B+random(-0.4, 0.3), 0.4);
  
    // here we use the noise value of a point to
    // define a direction (an angle)
    float a = noise(x/200, y/200) * TWO_PI;
    float l = random(1, 20);
    float x2 = x + l * sin(a);
    float y2 = y + l * cos(a); 
  
    strokeWeight(random(1,3));
    line(x,y, x2, y2);
  }
}
void keyPressed() {
  if(key == 's') {
    int n = int(random(100000));
    save(n + ".png");
  }
}
