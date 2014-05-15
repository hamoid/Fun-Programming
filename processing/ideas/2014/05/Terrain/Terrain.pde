/*
  Processing port of http://www.playfuljs.com/realistic-terrain-in-130-lines/
  by Jerome Herr and Abe Pazos
*/

TerrainP5 t;
void setup() {
  size(900, 500);
  t = new TerrainP5(8);
  doit();
}
void draw() {
}
void doit() {
  background(#C1EDF2);
  t.generate(0.7);
  t.draw();
}
void mousePressed() {
  doit();
}
void keyPressed() {
  if(key == 's') {
    saveFrame("####.jpg");
  }
}


class TerrainP5 {
  private final int tSize, tMax;
  private float[] tMap;
  private float tRoughness;

  TerrainP5(int detail) {
    tSize = int(pow(2, detail)+1);
    tMax = tSize-1;
    tMap = new float[tSize*tSize];
  }

  private float getp(int x, int y) {
    if (x < 0 || x > tMax || y < 0 || y > tMax) return -1;
    return tMap[x + tSize * y];
  }

  private void setp(int x, int y, float val) {
    tMap[x + tSize * y] = val;
  }

  public void generate(float roughness) {
    tRoughness = roughness;
    setp(0, 0, tMax);
    setp(tMax, 0, tMax / 2);
    setp(tMax, tMax, 0);
    setp(0, tMax, tMax / 2);

    divide(tMax);
  }

  private void divide(int sz) {
    int x, y, half = sz/2;
    float scale = tRoughness * sz;
    if (half < 1) return;

    for (y = half; y < tMax; y += sz) {
      for (x = half; x < tMax; x += sz) {
        square(x, y, half, random(-scale, scale));
      }
    }
    for (y = 0; y <= tMax; y += half) {
      for (x = (y + half) % sz; x <= tMax; x += sz) {
        diamond(x, y, half, random(-scale, scale));
      }
    }
    divide(sz/2);
  }

  private float average(float[] values) {
    int valid = 0;
    float total = 0;
    for (int i=0; i<values.length; i++) {
      if (values[i] != -1) {
        valid++;
        total += values[i];
      }
    }
    return valid == 0 ? 0 : total / valid;
  }

  private void square(int x, int y, int sz, float offset) {
    float ave = average(new float[] {
      getp(x - sz, y - sz), // upper left
      getp(x + sz, y - sz), // upper right
      getp(x + sz, y + sz), // lower right
      getp(x - sz, y + sz)  // lower left
    }
    );
    setp(x, y, ave + offset);
  }

  private void diamond(int x, int y, int sz, float offset) {
    float ave = average(new float[] {
      getp(x, y - sz), // top
      getp(x + sz, y), // right
      getp(x, y + sz), // bottom
      getp(x - sz, y)  // left
    }
    );
    setp(x, y, ave + offset);
  }

  public void draw() {
    float waterVal = tSize * 0.3;

    for (int y = 0; y < tSize; y++) {
      for (int x = 0; x < tSize; x++) {
        float val = getp(x, y);
        PVector top = project(x, y, val);
        PVector bottom = project(x + 1, y, 0);
        PVector water = project(x, y, waterVal);

        color c1 = tBrightness(x, y, getp(x + 1, y) - val);
        colorRect(top, bottom, c1);

        color c0 = color(50, 150, 200, 256 * 0.15);
        colorRect(water, bottom, c0);
      }
    }
  }
  private void colorRect(PVector top, PVector bottom, color c) {
    if (bottom.y < top.y) return;
    noStroke();
    fill(c);
    rect(top.x, top.y, bottom.x - top.x, bottom.y - top.y);
  }

  private color tBrightness(float x, float y, float slope) {
    if (y == tMax || x == tMax) return color(0);
    return color(slope * 50 + 128);
  }

  private PVector iso(float x, float y) {
    return new PVector(0.5 * (tSize + x - y), 0.5 * (x + y));
  }

  private PVector project(float flatX, float flatY, float flatZ) {
    PVector point = iso(flatX, flatY);
    float x0 = width * 0.5;
    float y0 = height * 0.2;
    float z = tSize * 0.5 - flatZ + point.y * 0.75;
    float x = (point.x - tSize * 0.5) * 6;
    float y = (tSize - point.y) * 0.005 + 1;

    return new PVector(x0 + x/y, y0 + z/y);
  }
}

