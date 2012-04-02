size(400, 400);

for(float x = 0; x < 1; x+=0.005) {
  float xx = x*6 - 3;
  // simplified formula to generate a bell curve (normal distribution)
  float y = pow(2, -xx*xx);
  line(width*x, 0, width*x, height - y*height);
}

stroke(255, 0, 0);
line(0, height/2, width, height/2);
line(width/2, 0, width/2, height);
