ControlFrame addControlFrame(String theName, int theWidth, int theHeight) {
  Frame f = new Frame(theName);
  ControlFrame p = new ControlFrame(this, theWidth, theHeight);
  f.add(p);
  p.init();
  f.setTitle(theName);
  f.setSize(p.w, p.h);
  f.setLocation(100, 100);
  f.setResizable(false);
  f.setVisible(true);
  return p;
}


public class ControlFrame extends PApplet {
  int w, h;
  int abc = 100;
  RadioButton fileList, modeList;
  File[] files;

  public void setup() {
    size(w, h);
    background(0);    
    frameRate(15);

    cp5 = new ControlP5(this);

    fileList = cp5.addRadioButton("fileList")
      .setPosition(10, 20)
      .setSize(16, 16);
    for(int i=0; i<files.length; i++) {
      fileList.addItem(files[i].getName(), i);
    }

    modeList = cp5.addRadioButton("modeList")
      .setPosition(10, 80)
      .setSize(16, 16);
    modeList.addItem("Histogram", 3);
    modeList.addItem("Top", 1);
    modeList.addItem("Landscape", 2);
    modeList.addItem("Sphere", 4);
    modeList.setNoneSelectedAllowed(true);
    modeList.activate(0);
    
    cp5.addButton("saveImage")
      .setPosition(10, 180);
  }

  void fileList(int i) {
    dataLoader.load(i);
  }
  void modeList(int i) {
    do_render(i);
  }
  void saveImage(int i) {
    saveRequested = true;
  }

  public void draw() {
  }

  public void setFiles(File[] files) {
    this.files = files;
  }
  
  private ControlFrame() {
  }
  public ControlFrame(Object theParent, int theWidth, int theHeight) {
    parent = theParent;
    w = theWidth;
    h = theHeight;
  }

  public ControlP5 control() {
    return cp5;
  }  

  ControlP5 cp5;
  Object parent;
}
