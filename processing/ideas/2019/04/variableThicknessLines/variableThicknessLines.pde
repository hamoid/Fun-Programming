PShader fx;

String[] files = {
  "18_line_sin"
}; 

final static int numVertices = 100;

PVector r = PVector.random3D();

void setup() {
  size(600, 600, P3D);
  colorMode(HSB, 1.0);
  hint(DISABLE_OPTIMIZED_STROKE);
  loadShaders(0);
  strokeWeight(10);
}

void draw() {
  background(#FEF8F4);
  noFill();

  float t = frameCount * 0.001;

  for (float offset=0; offset<1.0; offset += 0.03) {
    beginShape();
    stroke(offset, 0.2, 0.6, 0.5);
    for (int i=0; i<numVertices; i++) {
      float a = TAU * i / (float)numVertices;
      vertex(
        300 + 200 * sin(a * cos(offset + r.x - t * 0.2)) * sin(3 * r.z * offset + t), 
        300 + 200 * cos(a + t * 2) * sin(3 * offset + 4 * r.y + t * 0.1) 
        );
    }
    endShape();
  }
  fill(0.1);
  text(frameRate, 50, height-50);
}

void keyPressed() {
  if (key >= '1' && key < '1' + files.length) {
    loadShaders(key - '1');
  }
  if (key == 'r') {
    r = PVector.random3D();
  }
  if (key =='s') { 
    save("thumb.png"); 
    println("saved!");
  }
}


void loadShaders(int id) {
  fx = loadShader(
    "" + files[id] + ".frag", 
    "" + files[id] + ".vert");

  shader(fx, LINES);
  fx.set("numVertices", numVertices);
  println("Shader actualizado", millis());
}
