size(400, 400);
colorMode(HSB);
// choose a random background color using Hue, Saturation and Brightness
background(random(255), random(50, 100), random(50, 100));
noFill();
stroke(255, 100);

float i = 0;
while(i < 70) {
  ellipse(width/2 + i, height/2-i, 100+i*5, 100-i*5);
  i = i + 1;
}

print("end");
