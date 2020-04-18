size(400,300);

background(#6AA21E);
noStroke();
smooth();

float c = 0;

while(c < 100) {
  fill(random(255));
  rect(200,10,50, 5);

  fill(255, 0, 0);
  rect(260,10,10, 5);

  rotate(0.02);
  c = c + 1;
}


