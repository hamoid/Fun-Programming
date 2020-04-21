class ShaderReloader {
  private PShader shader;
  private long fragPrevTs = -1, vertPrevTs = -1;
  private File fragFile, vertFile;
  private boolean ready = false;
  private PApplet parent;
  private PGraphics errorOverlay;
  private int reloadFreq = 60; // frames

  // ---------------------------------------------
  ShaderReloader(PApplet parent, String frag, String vert) {
    this.parent = parent;
    errorOverlay = createGraphics(parent.width, parent.height, P2D);
    fragFile = new File(dataPath(frag));
    vertFile = new File(dataPath(vert));
  }

  // ---------------------------------------------
  public void apply() {
    if (parent.frameCount % reloadFreq == 1 && shadersModified()) {
      tryLoadingShader();
    }

    if (ready) {
      shader.set("mouse", float(mouseX), float(parent.height-mouseY));
      shader.set("time", parent.frameCount * 0.01);

      try {
        parent.shader(shader);
      } 
      catch(Exception e) {
        writeOnErrorOverlay(e.getMessage());        
      }
    }
  }

  // ---------------------------------------------
  public void debug() {
    if(!ready) {
      parent.resetShader();
      hint(DISABLE_DEPTH_TEST);
      parent.camera();
      parent.image(errorOverlay, 0, 0);
      hint(ENABLE_DEPTH_TEST);
    }
  }

  // ---------------------------------------------
  void tryLoadingShader() {
    if (!fragFile.exists()) {
      writeOnErrorOverlay("File\n" + fragFile.getAbsolutePath() + "\nnot found");
      return;
    } else if (!vertFile.exists()) {
      writeOnErrorOverlay("File\n" + vertFile.getAbsolutePath() + "\nnot found");
      return;
    }

    try {  
      shader = loadShader(fragFile.getAbsolutePath(), vertFile.getAbsolutePath());
      // You have to set at least one uniform here to trigger syntax errors
      // see: https://github.com/processing/processing/issues/2268
      shader.set("sketchSize", float(parent.width), float(parent.height));
      ready = true;
    }     
    catch (RuntimeException e) {    
      writeOnErrorOverlay(e.getMessage());
    }
  }

  // ---------------------------------------------
  void writeOnErrorOverlay(String err) {
    println(err);
    int w = parent.width;
    int h = parent.height;
    errorOverlay.beginDraw();
    errorOverlay.clear();
    errorOverlay.noStroke();
    errorOverlay.fill(0, 150);
    errorOverlay.rect(0, 0, w, h);
    errorOverlay.fill(255, 50, 0);
    errorOverlay.textAlign(CENTER, CENTER);
    errorOverlay.textSize(18);
    errorOverlay.text(err, w * 0.1, h * 0.1, w * 0.8, h * 0.8);
    errorOverlay.endDraw();
    ready = false;
  }

  // ---------------------------------------------
  private boolean shadersModified() {
    long fragCurrTs = fragFile.lastModified();
    long vertCurrTs = vertFile.lastModified();

    boolean fragChanged = fragCurrTs != fragPrevTs;
    boolean vertChanged = vertCurrTs != vertPrevTs;

    fragPrevTs = fragCurrTs;
    vertPrevTs = vertCurrTs;
    
    return fragChanged || vertChanged;
  }
}