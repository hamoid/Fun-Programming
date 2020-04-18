size(400, 200);
noStroke();
colorMode(HSB); // hue saturation brightness

float x = 0;
while (x < width) {
  println(x / 500);
  float co = 255 * noise(x/500);
  fill(co, 255, 255);
  ellipse(x, 100, 20, 20);
  x = x + 40;
}

