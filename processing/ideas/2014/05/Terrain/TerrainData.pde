class TerrainData {
  private float[][] tMap;
  private float tRoughness;
  public final int tSize, tMax;

  TerrainData(int detail) {
    tMax = 2 << (detail-1);
    tSize = tMax + 1;    
    tMap = new float[tSize][tSize];
  }
  public void calculateHeights(float roughness) {
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

  public float getp(int x, int y) {
    if (x < 0 || x > tMax || y < 0 || y > tMax) return -1;
    return tMap[x][y];
  }

  private void setp(int x, int y, float val) {
    tMap[x][y] = val;
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
}

