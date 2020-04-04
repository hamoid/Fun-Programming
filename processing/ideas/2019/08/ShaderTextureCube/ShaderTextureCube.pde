PShader fx;
PShape cube;
PGraphics tex;

void setup() {
  size(640, 640, P3D);
  tex = createGraphics(200, 200, P3D);
  
  fx = loadShader("frag.glsl");
  tex.beginDraw();
  tex.shader(fx);
  tex.noStroke();
  tex.rect(0, 0, tex.width, tex.height);
  tex.endDraw();
  
  cube = makeCube();
  cube.setTexture(tex);
  fill(255);
  noStroke();
}

PShape makeCube() {
  PShape s = createShape();
  s.beginShape(QUADS);

  // +Z "front" face
  s.vertex(-1, -1, 1, 0, 0);
  s.vertex( 1, -1, 1, 1, 0);
  s.vertex( 1, 1, 1, 1, 1);
  s.vertex(-1, 1, 1, 0, 1);

  // -Z "back" face
  s.vertex( 1, -1, -1, 0, 0);
  s.vertex(-1, -1, -1, 1, 0);
  s.vertex(-1, 1, -1, 1, 1);
  s.vertex( 1, 1, -1, 0, 1);

  // +Y "bottom" face
  s.vertex(-1, 1, 1, 0, 0);
  s.vertex( 1, 1, 1, 1, 0);
  s.vertex( 1, 1, -1, 1, 1);
  s.vertex(-1, 1, -1, 0, 1);

  // -Y "top" face
  s.vertex(-1, -1, -1, 0, 0);
  s.vertex( 1, -1, -1, 1, 0);
  s.vertex( 1, -1, 1, 1, 1);
  s.vertex(-1, -1, 1, 0, 1);

  // +X "right" face
  s.vertex( 1, -1, 1, 0, 0);
  s.vertex( 1, -1, -1, 1, 0);
  s.vertex( 1, 1, -1, 1, 1);
  s.vertex( 1, 1, 1, 0, 1);

  // -X "left" face
  s.vertex(-1, -1, -1, 0, 0);
  s.vertex(-1, -1, 1, 1, 0);
  s.vertex(-1, 1, 1, 1, 1);
  s.vertex(-1, 1, -1, 0, 1);

  s.endShape();

  s.setStroke(false);
  s.setTextureMode(NORMAL);

  return s;
}

void draw() {
  // redraw the shader based texture
  fx.set("t", millis()*0.001);  
  tex.beginDraw();
  tex.rect(0, 0, tex.width, tex.height);
  tex.endDraw();
  
  background(255);
  
  // draw the cube
  translate(width/2, height/2, -100);
  rotateX(millis() * 0.0003);
  rotateY(millis() * 0.0002);
  scale(150);
  shape(cube);
}
