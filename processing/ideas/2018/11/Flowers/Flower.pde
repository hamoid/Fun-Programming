public class Flower {
  PVector pos0, pos1, pos;
  float a = 0;
  PShape trunk, flower;
  int tColor, fColor, pColor;
  int stage = 0;
  float flowerRad = 0;
  float flowerScale = 0;
  int numPetals;
  float petalProgress = 0;
  float petalOverlap;
  float petalAspectRatio;
  float petalSpeed;
  float depth;
  Flower() {
    pos0 = PVector.random2D();
    pos0.mult(width * 0.8);
    pos0.add(width/2, height/2);

    pos1 = PVector.random2D();
    pos1.mult(width * random(0.1, 0.3));
    pos1.add(width/2, height/2);

    pos = pos0.copy();

    tColor = color(random(90, 140), random(130, 200), random(50, 140));
    trunk = createShape();
    createFlower();
    numPetals = (int)random(5, 14);
    petalOverlap = random(1, 1.2);
    petalAspectRatio = random(1, 3);
    petalSpeed = random(0.002, 0.01);
    depth = random(20);
  }

  void createFlower() {
    flowerRad = random(30, 80);
    colorMode(HSB, 360, 100, 100);
    float h = random(0, 57);
    fColor = color(h, random(40, 60), random(90, 100));
    pColor = color((h+180)%360, random(50), random(90, 100));
    colorMode(RGB, 255, 255, 255);
    flower = createShape(ELLIPSE, 0, 0, flowerRad, flowerRad);
    flower.setStroke(false);
    flower.setFill(fColor);
  }

  void draw() {
    pushMatrix();
    translate(0, 0, depth);
    
    shape(trunk);

    if (petalProgress > 0) {
      drawPetals(petalProgress);
    }

    drawCenter();

    switch (stage) {
    case 0:
      float dist1 = PVector.dist(pos, pos1);
      float dist0 = PVector.dist(pos, pos0);

      float distMin = min(dist0, dist1, 100) * 3;

      PVector dir = PVector.sub(pos1, pos);
      dir.normalize();
      dir.mult(5);
      pos.add(dir);

      float t = frameCount * 0.01;
      a += noise(t, pos.x * 0.001, pos.y * 0.001) - 0.5;

      PVector offset = new PVector(
        distMin * (noise(pos.x * 0.001, t)-0.48 + 0.2 * cos(a)), 
        distMin * (noise(pos.y * 0.001, t)-0.48 + 0.2 * sin(a)));

      offset.add(pos);

      if (dist1 < 8) {
        offset.set(pos1);
        stage++;
      }

      trunk.beginShape();
      trunk.strokeWeight(8);
      trunk.noFill();
      trunk.stroke(tColor);
      trunk.vertex(offset.x, offset.y);
      trunk.endShape();
      break;

    case 1:
      flowerScale = lerp(flowerScale, 1, 0.08);
      if (flowerScale > 0.99) {
        stage++;
      }
      break;

    case 2:
      petalProgress += petalSpeed;
      if(petalProgress > 1) {
        stage++;
      }
      break;
    }
    popMatrix();
  }

  void drawCenter() {
    pushMatrix();
    translate(pos1.x, pos1.y, 24);
    scale(flowerScale);
    shape(flower);
    popMatrix();
  }

  void drawPetals(float t) {
    float oneDur = 0.2;
    float availTime = 1 - oneDur; // 0.8
    float start = availTime / numPetals;
    noStroke();
    for(int i=0; i<numPetals; i++) {
      float petalSize = constrain(norm(t, i * start, i * start + oneDur), 0, 1);
      float a = cos(t*PI) + numPetals + TAU * i / numPetals;
      pushMatrix();
      translate(pos1.x, pos1.y, 21);
      rotate(a * (numPetals % 2 == 0 ? 1 : -1));
      translate(flowerRad/2, 0);
      rotateX(0.1);
      float n = petalOverlap * flowerRad*PI/numPetals;
      fill(lerpColor(pColor, #FFFFFF, (i * depth) % 1));
      ellipse(0, 0, petalAspectRatio*n*petalSize, n*petalSize);      
      popMatrix();
    }
  }
}
