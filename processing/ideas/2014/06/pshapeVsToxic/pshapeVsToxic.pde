import toxi.geom.*;
import toxi.geom.mesh.*;
import toxi.processing.*;

/*
 3D speed comparison using PShape and toxiclibs.
 
 In my computer it shows that PShape is much faster because it uses
 retained shapes (it needs to communicate less with the GPU).
 
 Press Space to toggle between modes and observe the length of the line.
 The console outputs vertex counts.
 
 The title of this post inspired the test  
 http://martinpblogformasswritingproject.blogspot.de/2012/06/retained-shape-for-toxiclibs-mesh.html
 
 To make the test more real, there's differenent meshes, and lights and
 textures are enabled. 
 */

PShape[] shp;
TriangleMesh[] shpToxic;
PImage img;
int objects = 1000;
int mode = 0;
int modes = 2;
String[] modeNames = { 
  "PShapes", "toxic"
};
int meshVariations = 50;
int trianglesPerMesh = 50;

ToxiclibsSupport renderToxic;

void setup() {
  size( 900, 600, P3D);
  noStroke();

  img = loadImage("http://lorempixel.com/300/300/people/#.jpg");
  textureMode(NORMAL);

  // rendering
  renderToxic = new ToxiclibsSupport(this);

  shpToxic = new TriangleMesh[meshVariations];
  shp = new PShape[meshVariations];

  for (int j=0; j<meshVariations; j++) {  
    shpToxic[j] = new TriangleMesh();
    shp[j] = createShape();
    shp[j].beginShape(TRIANGLES);
    shp[j].texture(img);
    float r = 40;
    for (int i=0; i<trianglesPerMesh; i++) {
      shp[j].vertex(random(r), random(r), random(r), u(j), v(j));
      shp[j].vertex(random(r), random(r), random(r), u(j), v(j));
      shp[j].vertex(random(r), random(r), random(r), u(j), v(j));

      shpToxic[j].addFace(
      new Vec3D(random(r), random(r), random(r)), 
      new Vec3D(random(r), random(r), random(r)), 
      new Vec3D(random(r), random(r), random(r)), 
      new Vec2D(u(j), v(j)), 
      new Vec2D(u(j), v(j)), 
      new Vec2D(u(j), v(j)));
    }
    shp[j].endShape();
  }

  println("pshape:", shp[0].getVertexCount(), "vertices per object");
  println("tox:", shpToxic[0].getNumVertices(), "vertices per object");
}
float u(float t) {
  float a = TAU * t / meshVariations; 
  return 0.5 + 0.35 * cos(a) + random(-0.13, 0.13);
}
float v(float t) {
  float a = TAU * t / meshVariations; 
  return 0.5 + 0.35 * sin(a) + random(-0.13, 0.13);
}

void draw() {
  background(#FEF8F0);
  directionalLight(255,200,150, 1, 1, 1);
  directionalLight(120, 140, 160, -1, -1, 1);

  objects += frameRate - 30;

  fill(0);
  text(modeNames[mode] + ": " + objects + " objects at " 
  + (int)frameRate + " fps", 50, 50);
  fill(255);

  translate(width/2, height/2);
  rotateX(millis() * 0.00011);
  rotateZ(millis() * 0.00001);
  for (int i=0; i<objects; i++) {
    pushMatrix();
    rotateZ(i * 0.0244);
    rotateY(i * 0.0311);
    translate(200, 0);
    // the order of the items in this switch statement
    // does not seem to significantly affect the results
    switch(mode) {
    case 1:
      renderToxic.texturedMesh(shpToxic[i % meshVariations], img, false);
      break;
    case 0:
      shape(shp[i % meshVariations]);
      break;
    }
    popMatrix();
  }
}
void keyPressed() {
  if (key == ' ') {
    mode = (mode + 1) % modes;
  }
  if(key == 's') {
    saveFrame("###.png");
  }
}
