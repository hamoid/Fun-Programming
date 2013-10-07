/* @pjs globalKeyEvents=true; pauseOnBlur=true; */

// Interactive word to shape conversion
// By Abe Pazos 28.06.2013
// http://funprogramming.org

static int MARGIN_LEFT = 70;
static int MARGIN_TOP = 150;
static int WORD_SPACE = 20;
static int FONT_HEIGHT = 60;
static int FONT_HEIGHT_MAX_SCALE = 2;
static int LINE_HEIGHT = 100;

String message = "Click here, then type something. ENTER to clear. DELETE as backspace.";
float cursorX=0, cursorY=0;

PVector[] vertex = new PVector[100];

void setup() {
  size(600, 600);
  colorMode(HSB, 1);
  background(1);
  frameRate(15);
  processText();
}
void draw() {
  cursorBlink();
}
void keyPressed() {
  background(1);
  if (keyCode == DELETE && message.length() > 0) {
    message = message.substring(0, message.length()-1);
  } 
  else if (keyCode == 10 || keyCode == 13) {
    message = "";
  }
  else if (key != CODED) {
    message += str(key);
  }
  processText();
}
void processText() {
  String[] words = split(message, ' ');
  float x=MARGIN_LEFT, y=MARGIN_TOP;

  cursorX=x;
  cursorY=y;

  for (int i=0; i<words.length; i++) {
    String currentWord = words[i];
    String lowerCaseWord = currentWord.toLowerCase();
    float wordWidth = textWidth(currentWord);
    int vCount = 0; 
    
    // next line is a trick, because .charAt() does
    // not work in processing.js (it returns string instead of char)
    int[] word = int(lowerCaseWord.toCharArray());

    // Fill vertex[] with the points belonging to each curve       
    vertex[vCount++] = new PVector(0, 0);
    for (int letter=0; letter<word.length; letter++) {
      float a, r, tx, ty;

      // Curves require at least 4 vertices
      // There are short words like "I", "no", "yes",
      // so I add extra vertices in those cases.

      if (word.length<2) {
        vertex[vCount++] = calcVertex(word[letter], 27, 4, 6);
      }
      vertex[vCount++] = calcVertex(word[letter], 13, 5, 5);
      vertex[vCount++] = calcVertex(word[letter], 17, 7, 3);
      if (word.length<3) {
        vertex[vCount++] = calcVertex(word[letter], 19, 3, 7);
      }
    }

    // Find the bounding box for each curve
    PVector topLeft = new PVector(1000, 1000);
    PVector bottomRight = new PVector(-999, -999);
    for(int v=1; v<vCount-1; v++) {
      if(vertex[v].x < topLeft.x) {
        topLeft.x = vertex[v].x;
      }
      if(vertex[v].x > bottomRight.x) {
        bottomRight.x = vertex[v].x;
      }
      if(vertex[v].y < topLeft.y) {
        topLeft.y = vertex[v].y;
      }
      if(vertex[v].y > bottomRight.y) {
        bottomRight.y = vertex[v].y;
      }
    }
    // Get the width and height of the curve
    PVector curveSize = PVector.sub(bottomRight, topLeft);
    // Calculate the size proportion between desired height an actual height
    float k = min(FONT_HEIGHT/curveSize.y, FONT_HEIGHT_MAX_SCALE);
    float maxWidth = max(wordWidth, curveSize.x*k);
    
    float letterX = x + maxWidth/2 + ((bottomRight.x-topLeft.x)/2.0 - bottomRight.x)*k;
    float letterY = y - textAscent() - bottomRight.y*k - 5;
      
    // draw letters
    noFill();
    curveTightness(0.5);
    beginShape();
    for(int v=0; v<vCount; v++) {
      curveVertex(
        letterX + k*vertex[v].x, 
        letterY + k*vertex[v].y
      );
    }
    endShape();

    // write text using normal characters
    fill(#9DA897);
    text(currentWord, x, y);

    cursorX = x + wordWidth + 5;
    cursorY = y;

    // move right / down
    x = x + maxWidth + WORD_SPACE;
    if (x > width-100) {
      x = MARGIN_LEFT;
      y += LINE_HEIGHT;
    }
  }
}
PVector calcVertex(int chr, float mod, int rmod, int rmul) {
  float a = TWO_PI*(chr % mod)/mod;
  float r = (chr % rmod)*rmul;            
  float tx = r*cos(a);
  float ty = r*sin(a);
  return new PVector(tx, ty);
}

void cursorBlink() {
  noStroke();
  fill(((int(frameCount/7) % 2) & 1) * 0.2 + 0.8);
  rect(cursorX, cursorY, 8, 2);
  stroke(0);
}
/*
void mousePressed() {
  saveFrame(millis()+".png");
}
*/
