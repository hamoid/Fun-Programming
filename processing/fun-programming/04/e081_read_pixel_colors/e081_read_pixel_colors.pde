void setup() {
  size(500, 400);
  
  for(int x = 0; x < width; x++) {
    for(int y = 0; y < 120; y++) {
      float r = map(noise(x / 80.0, y / 80.0, 10.0), 0, 1, 0, 255);
      float g = map(noise(x / 80.0, y / 80.0, 20.0), 0, 1, 0, 255);
      float b = map(noise(x / 80.0, y / 80.0, 30.0), 0, 1, 0, 255);
      stroke(r, g, b);
      point(x, y);
    }
  }
}

void draw() {
  color color_under_mouse = get(mouseX, mouseY);
  fill(color_under_mouse);
  rect(0, 120, width, 280);
}
