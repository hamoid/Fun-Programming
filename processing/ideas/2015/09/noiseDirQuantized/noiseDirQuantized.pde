File[] files;
PVector pos, center;
float dir, baseDir;
float speed, longestSize;
float maxDist = 0.75;
int angles = 6;
ArrayList<PVector> vertices;
PImage img;

void setup() {
  size(1000, 1000);
  files = (new File("/home/funpro/Pictures - Nexus One/Instagram")).listFiles();
  colorMode(HSB);
  smooth();
  strokeCap(PROJECT);
  noFill();
  vertices = new ArrayList<PVector>();
  center = new PVector(width/2, height/2);

  newImage();
  begin();
}
void begin() {
  pos = center.copy();
  float dist = width * maxDist * random(1, 1.02) * (random(100) < 50 ? 1 : 0.5);
  float angle = random(TAU);
  pos.add(dist*cos(angle), dist*sin(angle));

  dir = random(TAU);
  speed = 3;
}
void calcRoute() {
  vertices.clear();
  do {
    vertices.add(pos.copy());
    float tdir = (baseDir + 5 * noise(pos.x * 0.01, pos.y * 0.01, frameCount * 0.005));
    float qdir = baseDir + (TAU / angles) * (int)(degrees(tdir)/(360/angles));
    dir = lerp(dir, qdir, 0.3);
    pos.add(speed*cos(dir), speed*sin(dir));
  } while (pos.dist(center) < width*maxDist);
}
void draw() {
  if (frameCount % 10 == 0) {
    blendMode(SUBTRACT);
    noStroke();
    fill(1);
    rect(0, 0, width, height);
    noFill();
    blendMode(BLEND);
  }

  do {
    calcRoute();
    longestSize = max(vertices.size(), longestSize);
    begin();
  } while (vertices.size() < longestSize * 0.02);

  if (vertices.size() > longestSize * 0.85) {
    strokeWeight(1 << ((int)random(6)));
    //stroke((baseHue + (256/3) * (vertices.size()/20)) % 256, 255, random(100, 200));
    float a = baseDir + vertices.size() * 0.1;
    int x = (int)(img.width * 0.5 + img.width * 0.45 * cos(a));
    int y = (int)(img.height * 0.5 + img.height * 0.45 * sin(a));
    stroke(img.get(x, y));
  } else {
    strokeWeight(1 << ((int)random(3)));
    stroke((vertices.size()*10) % 90); // 200 +
  }

  beginShape();
  for (PVector v : vertices) {
    vertex(v.x, v.y);
  }
  endShape();
}
void newImage() {
  noiseSeed(millis());
  longestSize = 1;
  int which = (int)random(files.length);
  img = loadImage(files[which].getAbsolutePath());
}
void keyPressed() {
  if (key == ' ') {
    background(0);
    baseDir = random(TAU);
  }
  if (key == ENTER) {
    newImage();
  }
  if (key == 's') {
    save(System.currentTimeMillis() + ".png");
  }
}