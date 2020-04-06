PShader fx;
int colors[] = { #BF496A, #B39C82, #B8C99D, #F0D399, #595151, #BF496A, #B39C82, #B8C99D };
boolean redraw = false;
PShape square;
void setup() {
  size(1200, 700, P3D);
  noStroke();
  hint(DISABLE_OPTIMIZED_STROKE);
  reload();
  background(colors[0]);
  
  // a square with 100 vertices
  // per side, so it can be deformed
  // with the vertex shader
  square = createShape();
  square.beginShape();
  for (int i=0; i<100; i++) { 
    square.vertex(100-i, 0);
  }
  for (int i=0; i<100; i++) { 
    square.vertex(0, i);
  }
  for (int i=0; i<100; i++) { 
    square.vertex(i, 100);
  }
  for (int i=0; i<100; i++) { 
    square.vertex(100, 100-i);
  }
  square.endShape(CLOSE);
}

void draw() {
}

void mousePressed() {
  int columns = width / 100;
  int rows = height / 100;
  for (int x=0; x<columns; x++) {
    for (int y=0; y<rows; y++) {
      //int x = mouseX / 100;
      //int y = mouseY / 100;
      float a = x * y;
      float d = 100;
      int c = colors[floor(colors.length * noise(x * 0.2, y * 0.8, frameCount * .01))];
      fx.set("center", d*sin(a), d*cos(a));
      fx.set("u_color", red(c) / 255.0, green(c) / 255.0, blue(c) / 255.0);
      pushMatrix();
      translate(x * 100, y * 100);
      shape(square);
      popMatrix();
    }
  }
}
void keyPressed() {
  if (key == ' ') {
    reload();
  }
  if (key == 's') {
    save("thumb.jpg");
  }
}
void reload() {
  fx = loadShader("ColorFrag.glsl", "ColorVert.glsl");
  shader(fx);
  fx.set("rotation", QUARTER_PI);
}
