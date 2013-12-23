// size for the text
int minSz = 27;
int maxSz = 37;

// empty space around the image
int margin = 30;

// condensing space between lines
float vDist = 1.12;
// condensing space between characters
float hDist = 0.71;

// vertical jitter
float vJitter = 0.05;

// amount of vertical warping
float noiseAmount = 100;
// speed of vertical warping
float noiseSpeed = 0.005;

// how often we get horizontally flipped letters
float flippedFrq = 0.03;

// amount of rotation
float rotAmount = 0.08;

String lines[];

void setup() {
  size(875, 875);
  colorMode(HSB);
  fill(255);
  textAlign(CENTER, CENTER);
  shake();
}

void draw() {
}

void mousePressed() {
  shake();
}

void shake() {
  background(random(255), 100, 80);
  lines = loadStrings("text.txt");

  float dy = 0;
  float dx = 0;
  float x = random(margin, margin*2);
  float y = margin;

  for (int i = 0 ; i < lines.length; i++) {
    for (int c = 0; c < lines[i].length(); c++) {
      char thechar = lines[i].charAt(c);
      float sz = rnd(minSz, maxSz);
      float verticalJitter = rnd(-sz*vJitter, sz*vJitter);
      float rotation = rnd(-rotAmount, rotAmount);
      textSize(sz);

      pushMatrix();
      translate(x, y+verticalJitter+noiseAmount*noise(x*noiseSpeed, (y+verticalJitter)*noiseSpeed));
      rotate(rotation);
      if(random(1) < flippedFrq) {
        scale(-1, 1);
      }
      text(thechar, 0, 0);
      popMatrix();

      dx++;
      // blank widths are doubled (character 32)
      x += textWidth(thechar) * hDist * (thechar == 32 ? 2 : 1);

      if (x > width - random(margin, margin*2)) {
        x = random(margin, margin*2);
        dx = 0;
        dy++;
        y+=minSz * vDist;
      }
    }
    x = margin;
    y+=minSz * vDist;
  }

  save("text.png");
}

// I use randomGaussian() to sometimes have random values
// that are far out. I like exceptions.
float rnd(float a, float b) {
  return map(randomGaussian(), -1, 1, a, b);
}

