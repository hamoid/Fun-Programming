import toxi.geom.*;

Matrix4x4 m;
ArrayList<Vec3D> points;

PImage img;

void setup() {
  size(900, 900, P2D);
  background(255);
  img = makeGradient();
}
void draw() {
  // Create Polygon
  points = new ArrayList<Vec3D>();
  float rad = (frameCount * 3) % (width * 0.4);
  float theta = frameCount * 0.6;
  float cx = width/2 + rad*sin(theta);
  float cy = height/2 + rad*cos(theta);
  for (float a=0; a<TWO_PI; a+=random(0.1, 2)) {
    points.
      add(Vec3D.fromXYTheta(a).
      scaleSelf(width/10, height/10, 0).
      addSelf(cx, cy, 0));
  }

  // Find longest side and get length
  float maxDist = 0;
  int maxDistIndex = -1;
  for (int i=0; i<points.size (); i++) {
    Vec3D v1 = points.get(i);
    Vec3D v2 = points.get((i+1)%points.size());
    float d = v1.distanceTo(v2);
    if (d > maxDist) {
      maxDist = d;
      maxDistIndex = i;
    }
  }
  // Calculate inclination of longest side
  Vec3D v1 = points.get(maxDistIndex);
  Vec3D v2 = points.get((maxDistIndex+1)%points.size());
  float ang = HALF_PI - atan2(v2.y-v1.y, v2.x-v1.x);
  
  m = new Matrix4x4();
  m.rotateZ(ang);
  m.scaleSelf(1 / maxDist);

  textureMode(NORMAL);
  textureWrap(REPEAT);

  tint((new int[] {#074267,#0BC1C1,#EAE47E,#F8C579,#F35330})[frameCount % 5]);

  stroke(0, 30);
  beginShape();
  texture(img);
  for(Vec3D p : points) {
    Vec3D tp = p.sub(v1);
    m.applyToSelf(tp);
    vertex(p.x, p.y, tp.x * 0.5 + 0.5, tp.y);
  }
  endShape();  

  //noLoop();
}

PImage makeGradient() {
  img = createImage(600, 600, RGB);
  img.loadPixels();
  for (int x=0; x<img.width; x++) {
    for (int y=0; y<img.height; y++) {
      float d = 1-abs(x-300)/300.0;
      int c = color(map(1-pow(d, 4), 1, 0, 200, 150));
      img.pixels[x+y*img.width] = c;
    }
  }
  img.updatePixels();
  return img;
}
void keyPressed() {
    if(key =='s') { save("thumb.jpg"); println("saved!"); }
}
