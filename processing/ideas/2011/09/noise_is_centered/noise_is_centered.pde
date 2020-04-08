size(400, 400);
background(235, 232, 230);
strokeWeight(15);
float x = 0;

while(x < width) {
  float n = noise(x/40);

  // The blue line shows that noise spends most of the time
  // at the center. Rarely, if ever, it will go to the top
  // or to the bottom.
  stroke(40, 40, 200, 100);
  point(x, n*height);

  // This is an attempt to fix that.
  // We modify the noise value (n) in a way that the
  // whole range of values is covered: from 0 to 1.
  // One drawback with this formula is that it's not
  // continuous. It can disappear on the top and then
  // appear on the bottom.
  // The red line shows the modified noise value.
  if (n > 0.5) {
    n = (n - 0.5) * 2;
  } else {
    n = n * 2;
  }
  stroke(200, 40, 40, 100);
  point(x, n*height);

  x = x + 1;
}
