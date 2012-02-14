void draw() {
  if (mousePressed == true) {
    point(mouseX,mouseY);
  }
}

void keyPressed() {
	save("my_drawing.png");
}
