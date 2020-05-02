void recursiveLine(float x1, float y1, float x2, float y2, int iterations) {
  float d = dist(x1, y1, x2, y2);
  float dd = max(dist(width/2, height/2, x1, y1), dist(width/2, height/2, x2, y2));

  if (iterations > 0 && dd < 400) {
    stroke(lerpColor(#622A0E, #FFFFFF, norm(iterations, 15, 0) * 0.8 + 0.2 * noise(x1*0.03, y1 * 0.03)));
    strokeWeight(max(iterations, 1));
    line(x1, y1, x2, y2);

    boolean first = random(100) < 50;

    float len, angle;
    if (first || random(100) < 90) {
      len = random(0.5, 1) * d;
      angle = random(TAU);
      recursiveLine(x1, y1, x1+len*cos(angle), y1+len*sin(angle), iterations-1);
    }

    if (!first || random(100) < 90) {
      len = random(0.5, 1) * d;
      angle = random(TAU);
      recursiveLine(x2, y2, x2+len*cos(angle), y2+len*sin(angle), iterations-1);
    }
  }
}

void setup() {
  size(900, 900);
  background(#C65116);
  rectMode(CENTER);
}

void draw() {
}

void keyPressed() {
  if (key == 's') {
    save(System.currentTimeMillis() + ".png");
  }
  if (key == ' ') {
    background(#C65116);
  }
}
void mousePressed() {
  noStroke();
  fill(#C65116, 100);
  rect(width/2, height/2, width, height);
  filter(BLUR, 1);

  float angle = random(TAU);
  float x = mouseX + 200 * cos(angle);
  float y = mouseY + 200 * sin(angle);
  recursiveLine(mouseX, mouseY, x, y, 15);
}

