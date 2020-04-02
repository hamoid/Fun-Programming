import peasy.*;
import java.io.*;
import nervoussystem.obj.*;
PeasyCam cam;

boolean export = false;

void setup() {
  frameRate(15);
  size(540, 540, P3D);
  noStroke();
  cam = new PeasyCam(this, 10);
  cam.setMinimumDistance(0.0001);
  cam.setMaximumDistance(500);

  try {
    FileInputStream fileIn = new FileInputStream(sketchPath("camera.ser"));
    ObjectInputStream in = new ObjectInputStream(fileIn);
    CameraState state = (CameraState) in.readObject();
    cam.setState(state);
    in.close();
    fileIn.close();
  } catch(Exception e) {
  }
}

void draw() {
  background(40);
     
  lights();

  if(export) {
    OBJExport obj = (OBJExport) createGraphics(10,10,"nervoussystem.obj.OBJExport", sketchPath("boxesAreLight.obj"));
    obj.setColor(true);
    obj.beginDraw();
    obj.noFill();
    doit(obj);
    obj.endDraw();
    obj.dispose();
    export = false;
  }
  doit(this.g);
    
}

void doit(PGraphics pg) {
  pg.scale(5);
  pg.fill(255);
  int r = 8;
  for (int x=0; x<r*2; x++) {
    for (int y=0; y<r*2; y++) {
      for (int z=0; z<r*2; z++) {
        pg.pushMatrix();
        pg.translate(x, y, z);
        float n = noise(x * 0.2, y*0.2, z*0.2);
        pg.fill(noise(y * 0.2, x*0.2, z*0.2) > 0.5 ? 255 : 80);
        pg.box(n * r - 3);
        pg.popMatrix();
      }
    }
  }  
}

void keyPressed() {  
  if (key == ' ') {
    CameraState state = cam.getState();
    try {
      FileOutputStream fileOut = new FileOutputStream(sketchPath("camera.ser"));
      ObjectOutputStream out = new ObjectOutputStream(fileOut);
      out.writeObject(state);
      out.close();
      fileOut.close();
      println("camera position saved");
    } 
    catch(IOException i) {
    }
  }
  if(key == 'e') {
    export = true;
  }
  if(key == 'r') {
    noiseSeed(frameCount);
  }
  if(key == 's') {
    save("thumb.jpg");
    println("image saved");
  }
}
