File[] files;
PVector pos, center;
float dir, baseDir;
float speed, longestSize;
float maxDist = 0.45;
int angles = 6;
ArrayList<PVector> vertices;
PImage img;
PGraphics route;
PImage glow;

void setup() {
  size(1000, 1000, P2D);
  files = (new File("/home/funpro/Pictures/n1/Instagram")).listFiles();

  glow = createImage(width, height, ARGB);

  route = createGraphics(width, height);
  route.beginDraw();
  route.colorMode(HSB);
  route.smooth();
  route.strokeCap(PROJECT);
  route.noFill();
  route.endDraw();

  vertices = new ArrayList<PVector>();
  center = new PVector(width/2, height/2);

  newImage();
  begin();
}
void begin() {
  pos = center.copy();
  float dist = width * maxDist * random(1, 1.02); // * (random(100) < 50 ? 1 : 0.5);
  float angle = random(TAU);
  pos.add(dist*cos(angle), dist*sin(angle));

  dir = random(TAU);
  speed = 3;
}
void calcRoute() {
  vertices.clear();
  int iterations = 0;
  do {
    vertices.add(pos.copy());
    float tdir = (baseDir + 5 * noise(pos.x * 0.01, pos.y * 0.01, frameCount * 0.003));
    float qdir = baseDir + (TAU / angles) * (int)(degrees(tdir)/(360/angles));
    dir = lerp(dir, qdir, 0.3);
    pos.add(speed*cos(dir), speed*sin(dir));
  } while (pos.dist(center) < width*maxDist && iterations++ < 1000);
}
void draw() {
  // darken background
  if (frameCount % 10 == 0) {
    blendMode(SUBTRACT);
    noStroke();
    fill(1);
    rect(0, 0, width, height);
    noFill();
    blendMode(BLEND);
    println("darken", frameCount);
  }

  // find long enough route
  int it = 0;
  do {
    calcRoute();
    longestSize = max(vertices.size(), longestSize);
    begin();
  } while (vertices.size() < longestSize * 0.05 && it++ < 50);

  route.beginDraw();
  route.clear();
  // set route color depending on length
  int lineThickness = 1;
  if (vertices.size() > longestSize * 0.85) {
    lineThickness = 1 << ((int)random(6));
    //stroke((baseHue + (256/3) * (vertices.size()/20)) % 256, 255, random(100, 200));
    float a = baseDir + vertices.size() * 0.03;
    int x = (int)(img.width * 0.5 + img.width * 0.45 * cos(a));
    int y = (int)(img.height * 0.5 + img.height * 0.45 * sin(a));
    route.stroke(img.get(x, y));
  } else {
    lineThickness = 1 << ((int)random(3));
    route.stroke((vertices.size()*10) % 90); // 200 +
  }
  route.strokeWeight(lineThickness);

  // draw route
  route.beginShape();
  for (PVector v : vertices) {
    route.vertex(v.x, v.y);
  }
  route.endShape();
  route.endDraw();

  // shadow
  stroke(0, 30);
  strokeWeight(lineThickness);
  beginShape();
  noFill();
  for (PVector v : vertices) {
    vertex(v.x, v.y + lineThickness);
  }
  endShape();

  if (lineThickness > 1) {
    glow = route.copy();
    glow.filter(BLUR, lineThickness/2);
    blendMode(ADD);
    image(glow, 0, 0);
    blendMode(BLEND);
  } 

  image(route, 0, 0);
}
void newImage() {
  noiseSeed((int)random(999999));
  longestSize = 1;
  int which = (int)random(files.length);
  img = loadImage(files[which].getAbsolutePath());
  image(img, 0, 0, width, height);
  filter(BLUR, 20);
}
void keyPressed() {
  if (key == ' ') {
    background(0);
    baseDir = random(TAU);
  }
  if (key == ENTER) {
    newImage();
    begin();
  }
  if (key == 'a') {
    noiseSeed((int)random(999999));
  }
  if (key == 's') {
    save(System.currentTimeMillis() + ".png");
  }
}
