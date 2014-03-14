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

PGraphics hires;

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
  
  frameRate(10);

  hires = createGraphics(3000, 3000, P3D);
  hires.beginDraw();
  hires.colorMode(HSB);
  hires.background(0);
  hires.endDraw();
  
  dataLoader = new DataLoader();

  cf = addControlFrame("Control panel", 200, 450);
  cf.setFiles(dataLoader.files);
}
void draw() {
  if(saveRequested)
    saveImage();

  if (data != null && data.ready && !rendered) {
    rendered = true;
    do_render();  
  }
}
void do_render() {
  int t = millis();
  println("Start render, mode", vizMode);
  
  pushStyle();
  camera();
  lights();
  
  hires.pushStyle();
  hires.camera();
  hires.lights();  
  
  callFunctionByName("viz" + vizMode);
  
  popStyle();
  hires.popStyle();
  
  println("End render. Duration", (millis() - t) / 1000.0, "seconds");
}
void saveImage() {
  String low = "data/" + data.fileName + "_" + vizMode + ".tif";
  String high = "data/" + data.fileName + "_" + vizMode + "_hi.tif";
  
  println("saving");
  save(low);
  println("saved 1/2", low);
  hires.save(high);
  println("saved 2/2", high);
  
  saveRequested = false;
}
void callFunctionByName(String f) {
  try {
    Method viz = this.getClass().getDeclaredMethod(f);
    viz.invoke(this);
  } 
  catch(NoSuchMethodException e) {
    e.printStackTrace();
    rendered = true;
  }
  catch(Exception e) {
    e.printStackTrace();
  }
}
