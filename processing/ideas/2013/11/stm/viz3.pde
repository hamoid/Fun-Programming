void viz3() {
  pushStyle();
  camera();
  lights();

  background(255);
  stroke(0);
  
  int[] histogram = new int[512];
  for (int dy=0; dy<data.D[0].length; dy++) {
    for (int dx=0; dx<data.D.length; dx++) {
      float val = data.D[dx][dy];
      histogram[int(val * (histogram.length-1))]++;
    }
  }
  int hmax = 0;
  for (int i=0; i<histogram.length; i++) {
    if (histogram[i] > hmax)
      hmax = histogram[i];
  }
  for (int i=0; i<histogram.length; i++) {
    line(i, height, i, height-height*histogram[i]/float(hmax));
  }
  
  popStyle();
  
  rendered = true;
}
