size(500, 400);
background(255);
smooth();
noFill();

for (int i = 0; i < 30; i++) {
  bezier(
    width/2, height, 
    width/2, random(height), 
    random(width), random(height), 
    random(width), random(height)
  );
}

