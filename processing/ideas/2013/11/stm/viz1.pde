void viz1() {
  pushStyle();
  camera();
  lights();
  
  strokeWeight(2);
  for (int dy=0; dy<data.D[0].length; dy++) {
    for (int dx=0; dx<data.D.length; dx++) {
      float val = data.D[dx][dy];
      stroke((val * 256) % 256, 250 * val, 255 - 250*val);
      point(data.sx(dx), data.sy(dy));
    }
  }
  
  popStyle();
  rendered = true;
}
