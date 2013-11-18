/*
  
  Experiments visualizing Scanning Tunnelling Microscope data, from the paper titled
  "Ge(001) As a Template for Long-Range Assembly of π-Stacked Coronene Rows"

  Science Hack Day Berlin
  15 - 17.11.2013
  At Betahaus

  By Abe Pazos
  
*/
import java.io.FilenameFilter;
import java.lang.reflect.Method;
import java.awt.Frame;
import java.awt.BorderLayout;
import controlP5.*;

ControlFrame cf;

Data data;
DataLoader dataLoader;

// If we leave rendered as false it keeps rendering,
// which may be good for animating
boolean rendered = false;
// I use this variable to request a save from the control panel.
// If I directly call saveImage() it complains about threading in P3D.
boolean saveRequested = false;
// Initial visualization mode
int vizMode = 3;

void setup() {
  size(875, 875, P3D);
  colorMode(HSB);
  background(0);

  dataLoader = new DataLoader();

  cf = addControlFrame("Control panel", 200, 250);
  cf.setFiles(dataLoader.files);
}
void draw() {
  if(saveRequested)
    saveImage();

  if (data != null && data.ready && !rendered)
    do_render();  
}
void do_render() {
  pushStyle();
  camera();
  lights();
  callFunctionByName("viz" + vizMode);  
  popStyle();
}
void do_render(int mode) {
  vizMode = mode;
  rendered = false;
}
void saveImage() {
  saveFrame("data/" + data.fileName + "_" + vizMode + ".tif");
  saveRequested = false;
}
void callFunctionByName(String f) {
  try {
    Method viz = this.getClass().getDeclaredMethod(f);
    viz.invoke(this);
  } 
  catch(Exception e) {
    println(e);
  }
}
