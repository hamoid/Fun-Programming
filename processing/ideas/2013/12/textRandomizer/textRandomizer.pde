// size for the text
int minSz = 25;
int maxSz = 35;

// empty space around the image
int margin = 20;

// condensing space between lines
float vDist = 0.9;
// condensing space between characters
float hDist = 0.71;

String lines[];

void setup() {
  size(600, 900);
  colorMode(HSB);
  fill(255);
  textAlign(LEFT, CENTER);
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
  float x = margin;
  float y = margin;

  for (int i = 0 ; i < lines.length; i++) {
    for (int c = 0; c < lines[i].length(); c++) {
      char thechar = lines[i].charAt(c);
      float sz = rnd(minSz, maxSz);
      float verticalJitter = rnd(-sz/10.0, sz/10.0);
      float rotation = rnd(-0.08, 0.08);
      textSize(sz);

      pushMatrix();
      translate(x, y+verticalJitter);
      rotate(rotation);
      text(thechar, 0, 0);
      popMatrix();

      dx++;
      // blank widths are doubled (character 32)
      x += textWidth(thechar) * hDist * (thechar == 32 ? 2 : 1);

      if (x > width - margin) {
        x = margin;
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

