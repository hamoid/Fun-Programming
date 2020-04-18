PGraphics layer1, layer2;
void setup() {
  size(600, 600, P2D);
  layer1 = createGraphics(width, height, P2D);
  layer2 = createGraphics(width, height, P2D);

  for (int i=0; i<600; i+= 50) {
    layer1.beginDraw();
    layer1.colorMode(HSB);
    layer1.noStroke();
    layer1.fill(random(255), 255, 255);
    layer1.rect(i, 0, 50, height);
    layer1.endDraw();

    layer2.beginDraw();
    layer2.colorMode(HSB);
    layer2.noStroke();
    layer2.fill(random(255), 255, 255);
    layer2.rect(0, i, width, 50);
    layer2.endDraw();
  }
}

void draw() {
  if (mousePressed) {
    layer2.beginDraw();
    layer2.blendMode(MULTIPLY);
    ((PGraphicsOpenGL)layer2).pgl.blendFunc(PGL.ZERO, PGL.SRC_COLOR);
    layer2.fill(255, 240);
    layer2.ellipse(mouseX, mouseY, 40, 40);
    layer2.endDraw();
  }
  image(layer1, 0, 0);
  image(layer2, 0, 0);
}
