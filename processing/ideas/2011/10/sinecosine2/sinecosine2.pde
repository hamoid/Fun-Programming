// mouse click = restart
// hold [space] key for transparency
// [s] to save

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
float opacityMax = 0.3;
float opacity = opacityMax;
float opacity_d = 0;

void setup() {
  size(900, 900);
  w2 = width / 2;
  h2 = height / 2;
  colorMode(HSB, 1);
  smooth();
  noStroke();
  reset();
}

void reset() {
  a = 0;
  b = 0;
  bg = color(random(1), random(1), random(float(mouseX)/width));
  erasing = 30;
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

void draw() {
  if (erasing > 0) {
    fill(bg, 0.05);
    rect(0, 0, width, height);
    copy(2, 2, width-3, height-3, 0, 0, width, height);
    erasing--;
    return;
  }

  int times = 2;
  while (times-- > 0) {
    if (opacity_d != 0) {
      opacity += opacity_d;
      if (opacity < 0) {
        opacity = 0;
        opacity_d = 0.01;
        save(year() + "-" + month() + "-" + day() + "-" + hour() + "-" + minute() + "-" + second() + ".png");
      }
      if (opacity > opacityMax) {
        opacity = opacityMax;
        opacity_d = 0;
      }
    }
    set_stroke(co);

    float x0 = w2 + sin(a)*sin(b/k1)*w2*0.8;
    float y0 = h2 + cos(a)*sin(b/k1)*h2*0.8;

    float x1 = w2 + sin(b)*sin(a/k2)*w2*0.8;
    float y1 = h2 + cos(b)*sin(a/k2)*h2*0.8;

    sline(x0, y0, x1, y1);

    a = a + da;
    b = b + db;
    co = co + dco;
  }
}

void set_stroke(float n) {
  float sat = stretch(noise(n * 10, 10), 3);
  float bri = stretch(noise(n * 10, 15), 3);
  fill(n % 1, sat, bri, opacity);
}

void mousePressed() {
  reset();
}

void keyPressed() {
  if(key == ' ') {
    opacity_d = -0.01;
  }
  if(key == 's') {
    save(year() + "-" + month() + "-" + day() + "-" + hour() + "-" + minute() + "-" + second() + ".png");
  }
}

void sline(float x0, float y0, float x1, float y1) {
  noStroke();
  pushMatrix();
  translate(x0, y0);
  rotate(atan2(y1-y0, x1-x0));
  rect(0, 0, dist(x0, y0, x1, y1), 1);
  popMatrix();
}
