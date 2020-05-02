import wblut.math.*;
import wblut.processing.*;
import wblut.core.*;
import wblut.hemesh.*;
import wblut.geom.*;

int take = 0;
int framesToSave = 0;
int framesOneTake = 100;
int frameCurrent = 0;
float t;
Polygon[] poly = {
  new Polygon(5, 202, 202, -PI/10, PI/5),
  new Polygon(4, 221, 221, PI/2, -PI/4),
  new Polygon(3, 210, 201, HALF_PI, PI/3),
  new Polygon(100, 200, 200, 0, HALF_PI)
};
Polygon CP; // current polygon
HEC_Cylinder[] creator;

HE_Mesh mesh;
WB_Render render;

void setup() {
  size(550, 550, P3D);
  frameRate(30);
  smooth(8);
  noStroke();
  fill(#F77825);
  creator = new HEC_Cylinder[poly.length];
  
  for(int i=0; i<poly.length; i++) {
    creator[i] = new HEC_Cylinder();
    creator[i].setRadius(poly[i].radius0).setHeight(20);
    creator[i].setFacets(poly[i].sides).setSteps(1);
    creator[i].setCap(true,true);
    creator[i].setZAxis(0, 1, 0);
  }
  render=new WB_Render(this);
}

float ease(float n) {
  return 0.5 + 0.5 * cos(-PI + PI * n);
}
float easeOut(float n) {
  return cos(-HALF_PI + HALF_PI * n);
}
float easeIn(float n) {
  return 1 + cos(-PI + HALF_PI * n);
}
void draw() {
  background(#60B99A);

  frameCurrent = frameCount;
  float subt = 0;
  take = ((frameCurrent) / framesOneTake) % poly.length;
  CP = poly[take];
  t = (frameCurrent % framesOneTake) / (float) framesOneTake;
  translate(width/2 + CP.offset, height/2);
  if(t < 1.0/3) {
    // reveal shape
    subt = t * 3;
    rotateX(HALF_PI * easeOut(subt));
    rotateY(CP.rot0);
    //rotateY(CP.rot0 + CP.dir * (0.5 + 0.5 * cos(-PI + PI * subt * 2)) * CP.rot1);
  } else if(t < 2.0/3) {
    // flat rotate
    subt = (t - 1.0/3) * 3;
    rotateX(HALF_PI);
    rotateY(CP.rot0 + CP.rot1 * ease(subt));
  } else {
    // hide shape
    subt = (t - 2.0/3) * 3;
    rotateX(HALF_PI + easeIn(subt) * HALF_PI);
    rotateY(CP.rot0 + CP.rot1);
  }
  
  creator[take].setRadius(lerp(CP.radius0, CP.radius1, t));
  mesh = new HE_Mesh(creator[take]);
  int fn = mesh.getNumberOfFaces();
  for(int i=0; i<fn; i++) {
    HE_Face f = mesh.getFaceWithIndex(i);
    if(i<CP.sides) {
      f.setColor(#F1EFA5);
    } else {
      f.setColor(#F77825);
    }
  }
  render.drawFacesFC(mesh);
  
  if(framesToSave > 0) {
    saveFrame("/tmp/a/f####.gif");
    println(framesToSave);
    framesToSave--;
  }
}

void keyPressed() {
  switch(key) {
    case 'h':
      frameCurrent--;
      break;
    case 'n':
      frameCurrent++;
      break;
    case 'a':
      CP.radius0--;
      break;
    case 'o':
      CP.radius0++;
      break;
    case 'e':
      CP.radius1--;
      break;
    case 'u':
      CP.radius1++;
      break;
    case 's':
      framesToSave = framesOneTake * poly.length;  
      break;
    case 'p':
      for(Polygon p : poly) {
        println(p);
      }
      break;
  }
}
