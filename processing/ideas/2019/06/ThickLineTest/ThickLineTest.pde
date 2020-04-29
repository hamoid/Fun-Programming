ThickLine lines[] = new ThickLine[6];

void setup() {
  size(800, 800, P3D);

  for (int i=0; i<lines.length; i++) {
    float aa = TAU * i / lines.length;
    lines[i] = new ThickLine();
    float x = 200 * cos(aa);
    float y = 200 * sin(aa);

    for (float a = 0; a<TAU; a+=TAU/50) {
      lines[i].addPoint(
        x + 250 * cos(a), 
        y + 250 * sin(a), 
        30 * sin(2.7 + a * 3 + aa * 3), // z 
        30 + 15 * sin(a * 3 - aa)
        );
    }
    lines[i].setLoop(true);
    lines[i].recalculate();
  }
}

void keyPressed() {
  if (key == 's') {
    StringBuilder file = new StringBuilder();
    StringBuilder v = new StringBuilder();
    StringBuilder f = new StringBuilder();
    int i = 0;

    for (ThickLine l : lines) {
      l.calculateObj(v, f);
      file.append("o Shape" + i++ + "\n");
      file.append(v);
      file.append(f);
    }

    PrintWriter output;
    output = createWriter("/tmp/rings.obj");
    output.println(file);
    output.flush();
    output.close();
  }
}

void draw() {
  background(#3E1726);
  translate(width/2, height/2);
  for (ThickLine l : lines) {
    l.drawThick();

    hint(DISABLE_DEPTH_TEST);
    l.drawSpine();
    l.drawThickVertices();
    l.drawSpineVertices();
    hint(ENABLE_DEPTH_TEST);
  }
}
