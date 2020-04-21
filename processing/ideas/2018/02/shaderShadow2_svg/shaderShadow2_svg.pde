ShaderReloader shadow;
//PShader shadow;
PGraphics src, depth;
PShape letter;
int W = 800, H = 800;
boolean enabled = true;
float aspectRatio = 1;
void settings() {
  size(W, H, P2D);
}
void setup() {
  //frameRate(30);
  letter = loadShape("g.svg");
  letter.disableStyle();
  src = createGraphics(W*2, H*2, P2D);
  src.noSmooth();
  depth = createGraphics(W*2, H*2, P2D);
  depth.noSmooth();
  shadow = new ShaderReloader(depth, "shadowFrag.glsl", "shadowVert.glsl");
}

void draw() {
  aspectRatio = letter.height / letter.width;
  src.beginDraw();
  src.background(0);
  for (int i=1; i<256; i++) {
    // A
    //float n = map(i, 1, 256, 0, TAU);
    //float a = n +  millis() * 0.0001 + 0.5 * sin(n*2);
    //float r = map(sin(a*3+1), -1, 1, 50, src.width * 0.4);
    //float sz = src.width / 8 - sin(n*6) * src.width / 50;
    //float x = r * sin(a*4);
    //float y = r * cos(a*4);

    // B
    //float sz = 300 * noise(i * 0.1) - 30;
    //float x = map((i-1) % 16, 0, 15, src.width *0.85, src.width*0.15);
    //float y = map((int)((i-1) / 16), 0, 15, src.height*0.85, src.height*0.15);

    // C
    float sz = 1000 * noise(i * 0.1) - 200;
    //float x = map((int)(16*noise(i*0.1, frameCount * 0.01)), 0, 15, src.width, 0);
    //float y = map((int)(16*noise(i*0.1, 3.3, frameCount * 0.01)), 0, 15, src.height, 0);
    float x = src.width*noise(i*0.10 + frameCount * 0.001, 0.0) * 2 - src.width * .5;
    float y = src.height*noise(i*0.07 + frameCount * 0.002, 3.3) * 2 - src.height * .5;

    src.fill(i);
    src.noStroke();
    src.shapeMode(CENTER);
    src.pushMatrix();
    src.translate(x, y);
    src.rotate(TAU * noise(x*.001, y*.001, sz * .005));
    src.shape(letter, 0, 0, sz, sz * aspectRatio);
    src.popMatrix();
  }
  src.endDraw();

  shadow.apply();
  shadow.set("enabled", enabled);

  depth.beginDraw();            
  depth.image(src, 0, 0);
  depth.endDraw();

  image(depth, 0, 0, width, height);
  fill(0);
  text(enabled ? "drop shadow shader" : "plain", 20, height - 20);

  //saveFrame("/tmp/a/frm####.png");
  if (frameRate < 57) {
    println(frameRate);
  }
  shadow.debug();
}
void keyPressed() {
  switch(key) {
  case ' ':
    float r = floor(random(3));
    float g = floor(random(3));
    float b = floor(random(3));
    shadow.set("c0", 0.5, 0.5, 0.5);
    shadow.set("c1", 0.5, 0.5, 0.5);
    shadow.set("c2", r, g, b);
    shadow.set("c3", random(TAU), random(TAU), random(TAU));
    break;
  case ENTER:
    enabled = !enabled;
    break;
  case 'i':
    float fov = PI/3;
    float cameraZ = (height/2.0) / tan(fov/2);
    println(cameraZ/10, cameraZ*10);
    break;
  case 's':
    save("thumb.png");
    break;
  }
}
