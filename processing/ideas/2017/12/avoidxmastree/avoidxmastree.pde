import toxi.geom.nurbs.*;
import toxi.math.noise.*;
import toxi.geom.*;
import toxi.geom.mesh.*;
import toxi.processing.*;
import com.hamoid.*;

VideoExport videoExport;
ToxiclibsSupport toxic;
ArrayList<Branch> lines;
boolean started = false;
PImage bg;

void setup() {
  size(800, 800, P3D);
  toxic = new ToxiclibsSupport(this);
  //videoExport = new VideoExport(this, System.currentTimeMillis() + ".mp4");
  lines = new ArrayList<Branch>();
  bg = loadImage("bg.png");
}
void draw() {
  if (started) {
    background(255);
    image(bg, 0, 0, width, height);    
    for (Branch l : lines) {
      l.draw();
    }
    loadPixels();
    for (Branch l : lines) {
      l.update();
    }
    //videoExport.saveFrame();
  }
}
void keyPressed() {
  if (key == ' ') {
    background(255);
    started = true;
    loadPixels();
    //videoExport.startMovie();
    lines.clear();
    //for (int i=0; i<25; i++) {
    //  lines.add(new Branch());
    //}
  }
  if (key == ENTER) {
      lines.add(new Branch());
  }
  if (key == 'q') {
    videoExport.endMovie();
    exit();
  }
}