class Data {
  BufferedReader reader;
  String fileName;

  boolean ready = false;
  
  // Min and mav values found in the data
  float vmin, vmax;
  
  // Microscope images are 512x512
  int w = 512;
  int h = 512;
  
  float[][] D = new float[w][h];
  float[] histogram = new float[100];
  float topThreshold;

  Data(File f) {
    if (f == null)
      return;
      
    fileName = f.getName();
    println("Reading", fileName);

    String line;

    String path = f.getAbsolutePath();
    reader = createReader(path);
    
    vmin = 9999; 
    vmax = -9999;
    
    int y = 0;
    while (true) {
      try {
        line = reader.readLine();
      } 
      catch (IOException e) {
        line = null;
        e.printStackTrace();
      }
      if (line == null) {
        normalizeData();
        calculateHistogram();
        calculateThreshold();
        ready = true;
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
    println("Normalizing data. Min:", vmin, "Max:", vmax);
    for (int x=0; x<w; x++) {
      for (int y=0; y<h; y++) {
        D[x][y] = map(D[x][y], vmin, vmax, 0, 1);
      }
    }
  }
  
  // map to display size
  int sx(int dx) {
    return int(width * dx/float(w));
  }
  int sy(int dy) {
    return int(height * dy/float(h));
  }
  
  // map to 0..1
  float px(int dx) {
    return dx/float(w);
  }
  float py(int dy) {
    return dy/float(h);
  }
  
  void calculateHistogram() {
    for (int x=0; x<w; x++) {
      for (int y=0; y<h; y++) {
        float val = D[x][y];
        histogram[int(val * (histogram.length-1))]++;
      }
    }
    float hmax = 0;
    for (int i=0; i<histogram.length; i++) {
      if (histogram[i] > hmax)
        hmax = histogram[i];
    }
    for (int i=0; i<histogram.length; i++) {
      histogram[i] = histogram[i]/hmax;
    }
  }
  // Find a good threshold to highlight the highest peaks
  void calculateThreshold() {
    for (topThreshold = 0.99; topThreshold > 0; topThreshold -= 0.01) {
      int c = 0;
      for (int i=0; i<histogram.length; i++) {
        if (histogram[i] > topThreshold)
          c++;
      }
      // 10 bands of the histogram are above the threshold.
      // That's a good balance between rare and common.
      if (c > 10)
        break;
    }
    println("topThreshold", topThreshold);
  }
}
