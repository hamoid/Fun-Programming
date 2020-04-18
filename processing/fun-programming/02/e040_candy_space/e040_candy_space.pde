float z = 0;

void setup() {
  size(400, 200);
  noStroke();
  colorMode(HSB); // hue saturation brightness
}
void draw() {
  float x = 0;
  while (x < width) {

    float y = 0;
    while(y < height) {
      float co = 255 * noise(x/500, y/500, z);
      fill(co, 255, 255);
      ellipse(20 + x, 20 + y, 60, 60);
      y = y + 40;
    }    
    
    x = x + 40;
  }
  
  z = z + 0.02;
}

