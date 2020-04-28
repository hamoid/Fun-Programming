// Original: ideas/2013/06/shaderScroll/

import processing.video.*;
import com.hamoid.*;
import org.funprogramming.*;

VideoExport videoExport;
Movie movie;
PShader scroll;
PGraphics canvas, mask, black;
PImage buzz;
float angle, r;
boolean saveVideoFrame = false;

// ------------------------------------------
void settings() {
  fullScreen(P2D);
}
// ------------------------------------------
void setup() {
  surface.setTitle("sketch_scroll");

  canvas = createGraphics(displayWidth, displayHeight, P2D);
  canvas.beginDraw();
  canvas.noStroke();
  canvas.endDraw();

  black = createGraphics(displayWidth, displayHeight, P2D);
  black.beginDraw();
  black.background(0);
  black.endDraw();

  mask = createGraphics(displayWidth, displayHeight, P3D);
  mask.beginDraw();
  mask.background(0);
  mask.fill(0);
  mask.textMode(SHAPE);
  mask.textAlign(CENTER, CENTER);
  mask.textFont(createFont("Open Sans Extrabold", 96));
  mask.endDraw();

  buzz = loadImage("buzzwordipsum.png");
  noCursor();
}

// ------------------------------------------
void draw() {
  if (movie != null && movie.available()) {
    movie.read();
  }

  if (scroll != null) {
    scroll.set("n", map(noise(frameCount * 0.000337), 0.2, 0.8, -PI, PI));
    scroll.set("time", millis() * 0.001);
    canvas.filter(scroll);

    canvas.beginDraw();

    // Add random spot
    if (random(1) > 0.50) {
      canvas.fill(movie.get(movie.width/2, movie.height/2));
      canvas.ellipse(random(displayWidth), random(displayHeight), random(4), random(4));
    }

    int C1 = movie.get(movie.width/2, movie.height/3);
    int C2 = movie.get(movie.width/2, 2*movie.height/3);
    angle = lerpAngle(angle, 0.1 * hue(C1) + (frameCount / 300), 0.01);
    r = lerp(r, (1 + 2 * ((frameCount / 100) % 5)) * brightness(C2), 0.01 );    
    float x = displayWidth * 0.6 + r*sin(angle);
    float y = displayHeight * 0.5 + r*cos(angle);

    int flipTexY = 0; //frameCount % 2 == 0 ? height : 0; // too flickery

    for (int i=0; i<2; i++) {
      // Draw shape
      canvas.beginShape(TRIANGLE_STRIP);
      canvas.texture(movie);
      float t = millis() * 0.0001;
      float r = 3000;
      float k = 0.001;
      for (float a = t; a<t+4; a+=4/50.0) {
        float xx = x + r * noise(a, x * k, y * k) - r/2;
        float yy = y + r * noise(y * k, a, x * k) - r/2;
        float nx = x + r * noise(a+1, x * k, y * k) - r/2;
        float ny = y + r * noise(y * k, a+1, x * k) - r/2;
        canvas.vertex(xx, yy, 
          map(nx, 0, displayWidth, 0, movie.width), 
          map(ny, flipTexY, displayHeight - flipTexY, 0, movie.height));

        xx = x + r * noise(a, 0.05 + x * k, y * k) - r/2;
        yy = y + r * noise(y * k, a, 0.05 + x * k) - r/2;
        nx = x + r * noise(a+1, 0.05 + x * k, y * k) - r/2;
        ny = y + r * noise(y * k, a+1, 0.05 + x * k) - r/2;
        canvas.vertex(xx, yy, 
          map(nx, 0, displayWidth, 0, movie.width), 
          map(ny, flipTexY, displayHeight - flipTexY, 0, movie.height));
      }
      canvas.endShape();

      // Do symmetry
      //x = width - x;
      canvas.translate(displayWidth, 0);
      canvas.scale(-1, 1);
    }
    canvas.endDraw();
  }

  image(canvas, 0, 0);
  hint(DISABLE_DEPTH_TEST);
  drawOverlay();

  if (saveVideoFrame) {
    videoExport.saveFrame();
  }
}

void drawOverlay() {
  // option 1. Generate a mask
  /*
  mask.beginDraw();
  mask.background(255);
  for (float x = displayWidth * 0.2; x < displayWidth * 0.81; x += displayWidth * 0.1) {
    for (float y = displayHeight * 0.2; y < displayHeight * 0.81; y += displayHeight * 0.1) {
      mask.pushMatrix();
      mask.translate(x, y, 200 * noise(frameCount * 0.004 + y*0.001, x*0.001) - 100);
      mask.rotateZ(10 * noise(x*0.001, y*0.001 + frameCount * 0.002));
      //mask.rotateY(10 * noise(y*0.001 + frameCount * 0.003, x*0.001));
      mask.textSize(220);
      mask.text("2018", 0, 0);
      mask.popMatrix();
    }
  }
  mask.endDraw();
  black.mask(mask);
  image(black, 0, 0);
  */

  // option 2. Load a mask
  image(buzz, 0, -(frameCount % height));
  image(buzz, 0, height-(frameCount % height));
}
// ------------------------------------------
void keyPressed() {
  if (key == ' ') {
    String p = "/home/funpro/Videos/color-source/";
    //movie = new Movie(this, p + "drone.mp4");
    //movie = new Movie(this, p + "nature.mp4");
    movie = new Movie(this, p + "longtakes2/Children of men - Car Scene-QfBSncUspBk.mp4");
    //movie = new Movie(this, p + "longtakes2/Goodfellas - Tracking Shot (HQ)-kpvNjbtF9Hg.mp4");
    //movie = new Movie(this, p + "longtakes2/Long take-58129043.mp4");
    //movie = new Movie(this, p + "longtakes2/Pride and Prejudice [Long Take]-90948747.mp4");
    //movie = new Movie(this, p + "longtakes2/Spectre- Opening Tracking Shot in 1080p-cbqv1kbsNUY.mp4");
    //movie = new Movie(this, p + "longtakes2/The Long Take - The Place Beyond The Pines - Opening Scene-bsM30BEDxAw.mp4");
    //movie = new Movie(this, p + "longtakes2/The Protector 2005 Long take-zESe7U467vs.mp4");

    movie.loop();
    movie.frameRate(2);
    if (scroll == null) {
      scroll = canvas.loadShader("scrollFrag.glsl", "scrollVert.glsl");
    }
  }
  if (key == ENTER) {
    background(random(255), random(255), random(255));
    if(movie != null) {
      movie.jump(random(movie.duration() * 0.9));
    }
    noiseSeed(millis());
  }
  if (key == 's') {
    saveVideoFrame = !saveVideoFrame;
    if (saveVideoFrame) {
      exec("/usr/bin/espeak", "start");
      videoExport = new VideoExport(this, "/tmp/shaderScrollTextured.mp4");
      videoExport.setQuality(80, 128);
      videoExport.setFrameRate(30);  
      videoExport.setDebugging(false);
      videoExport.startMovie();
    } else {
      exec("/usr/bin/espeak", "stop");
      videoExport.endMovie();
      exit();
    }
  }
}
