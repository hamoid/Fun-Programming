import java.lang.reflect.Method;

int MODE = 2;
Data data;
boolean rendered = false;

void setup() {
  size(875, 875, P3D);
  colorMode(HSB);

  selectInput("Select a STM file:", "fileSelected", new File(
  "/home/funpro/Desktop/edu/src/processing/ideas/2013/11/stm/im010910A_29.txt"));
}
void fileSelected(File selection) {
  data = new Data(selection == null ? "" : selection.getAbsolutePath());
}
void draw() {
  if (data == null || !data.normalized || rendered)
    return;

  visualize();
}
void visualize() {
  try {
    Method viz = this.getClass().getDeclaredMethod("viz" + MODE);
    viz.invoke(this);
  } 
  catch(Exception e) {
    println(e);
  }
}
void keyPressed() {
  if (key == 's') {
    saveFrame(int(System.currentTimeMillis()) + ".tif");
  }
  if (key == '1' || key == '2' || key == '3') {
    MODE = parseInt("" + key);
    visualize();
  }
}
