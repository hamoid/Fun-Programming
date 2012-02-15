// mouse click = restart
// press any key = save image

float a = 0;
float b = 0;
float co = 0;
float da = 0;
float db = 0;
float dco = 0;
float k1 = 1;
float k2 = 1;
float w2 = 1;
float h2 = 1;
color bg;
int erasing = 30;

void reset() {
  a = 0;
  b = 0;
  bg = color(random(1), random(1), random(float(mouseX)/width));
  erasing = 50;
  da = random(0.002, 0.08);
  db = da / float(int(random(1, 5)));
  dco = da * db;
  k1 = int(random(2, 9));
  k2 = int(random(2, 9));
  noiseSeed(frameCount);
}

float stretch(float y, float expo) {
  if (y < 0.5) {
    y = pow(y*2, expo) / 2;
  } 
  else {
    y = 1 - y;
    y = 1 - pow(y*2, expo) / 2;
  }
  return y;
}
void set_stroke(float n) {
  float sat = stretch(noise(n * 10, 10), 3);
  float bri = stretch(noise(n * 10, 15), 3);
  stroke(n % 1, sat, bri, 1 - float(mouseY) / height);
}

void setup() {
  size(650, 650);
  w2 = width / 2;
  h2 = height / 2;
  colorMode(HSB, 1);
  smooth();
  strokeWeight(1);
  reset();
}
void draw() {
  if (erasing > 0) {
    fill(bg, 0.05);
    rect(0,0,width,height);
    copy(2,2,width-3, height-3, 0, 0, width, height);
    erasing--;
  }
  set_stroke(co);
  
  float x0 = w2 + sin(a)*sin(b/k1)*w2*0.8;
  float y0 = h2 + cos(a)*sin(b/k1)*h2*0.8;
  
  float x1 = w2 + sin(b)*sin(a/k2)*w2*0.8;
  float y1 = h2 + cos(b)*sin(a/k2)*h2*0.8;
    
  line(x0, y0, x1, y1);
  
  a = a + da;
  b = b + db;
  co = co + dco;
}
void mousePressed() {
  reset();
}
void keyPressed() {
  save(year() + "-" + month() + "-" + day() + "-" + hour() + "-" + minute() + "-" + second() + ".png");
}
