/*
    Copyright 2013 Abe Pazos
    
    http://funprogramming.org
    http://hamoid.com

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

// size for the text
int minSz = 25;
int maxSz = 32;

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
  textAlign(CENTER, CENTER);
  shake();
}

void draw() {
}

void mousePressed() {
  shake();
}

void shake() {
  fill(random(255), 20, 160);
  background(255);
  lines = loadStrings("text.txt");

  float x = random(margin, width * 0.3);
  float y = 0;  
  float lineWidth = random(width * 0.7, width - margin);

  for (int i = 0 ; i < lines.length; i++) {
    int c = 0;
    while(c < lines[i].length()) {
      char thechar = lines[i].charAt(c);
      float sz = rnd(minSz, maxSz);
      float verticalJitter = rnd(-sz*vJitter, sz*vJitter);
      float rotation = rnd(-rotAmount, rotAmount);
      textSize(sz);

      float currX = x;
      float currY = y + verticalJitter;
      currY += noiseAmount * noise(x * noiseSpeed, currY * noiseSpeed); 

      pushMatrix();
      translate(currX, currY);
      rotate(rotation);
      // horizontal flip
      if(random(1) < flippedFrq) {
        scale(-1, 1);
      }
      // add random spaces
      if(noise(currX, currY) > 0.3) {
        text(thechar, 0, 0);
        c++;
      }
      popMatrix();

      // blank widths are doubled (character 32)
      x += textWidth(thechar) * hDist * (thechar == 32 ? 2 : 1);

      if (x > lineWidth) {
        x = random(margin, width * 0.3);
        y += minSz * vDist;
        lineWidth = random(width * 0.7, width - margin);
      }
    }
    x = random(margin, width * 0.3);
    y += minSz * vDist;
  }

  save("text.png");
}

// I use randomGaussian() to sometimes have random values
// that are far out. I like exceptions.
float rnd(float a, float b) {
  return map(randomGaussian(), -1, 1, a, b);
}

