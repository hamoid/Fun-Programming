class Data {
  BufferedReader reader;
  String line;

  boolean normalized = false;
  float vmin = 9999, vmax = -9999;
  int w = 512;
  int h = 512;
  float[][] D = new float[w][h];

  Data(String path) {
    println("Reading", path);
    reader = createReader(path);
    int y = 0;
    while (true) {
      try {
        println("Read", y);
        line = reader.readLine();
      } 
      catch (IOException e) {
        line = null;
        e.printStackTrace();
      }
      if (line == null) {
        normalizeData();
        return;
      }
      String[] values = split(line, TAB);
      for (int x=0; x<w; x++ ) {
        float val = float(values[x]);
        if (val < vmin) vmin = val;
        if (val > vmax) vmax = val;
        D[x][y] = val;
      }
      y++;
    }
  }
  void normalizeData() {
    print("Normalizing data. Min:", vmin, "Max:", vmax);
    for (int x=0; x<w; x++) {
      for (int y=0; y<h; y++) {
        D[x][y] = map(D[x][y], vmin, vmax, 0, 1);
      }
    }
    normalized = true;
  }
  int sx(int dx) {
    return int(width * dx/float(w));
  }
  int sy(int dy) {
    return int(width * dy/float(h));
  }
  float px(int dx) {
    return dx/float(w);
  }
  float py(int dy) {
    return dy/float(h);
  }
}
