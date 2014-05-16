class TerrainSimpleRender {  
  TerrainData tData;
  boolean fast;

  TerrainSimpleRender(TerrainData tData, boolean fast) {    
    this.tData = tData;
    this.fast = fast;
  }

  public void draw() {
    float waterVal = tData.tSize * 0.3;

    noStroke();
    color waterColor = color(50, 150, 200, 256 * 0.15);

    PVector surface = new PVector();
    PVector bottom = new PVector();
    PVector water = new PVector();

    // Using nested loops instead of one loop does not make
    // a significant difference in rendering speed  
    for (int y = 0; y < tData.tSize; y++) {
      for (int x = 0; x < tData.tSize; x++) {
        float val = tData.getp(x, y);
        project(surface, x, y, val);
        project(water, x, y, waterVal);
        project(bottom, x + 1, y, 0);

        if (y != tData.tMax && x != tData.tMax) {
          float slope = tData.getp(x + 1, y) - val;
          fill(slope * 50 + 128);
          drawRect(surface, bottom, 10);

          // don't draw water if it's underground
          if (water.y < surface.y) {
            fill(waterColor);
            drawRect(water, bottom, 5000);
          }
        } 
        else {
          fill(0);
          drawRect(surface, bottom, 5000);
        }
      }
    }
  }
  private void drawRect(PVector a, PVector b, int maxSurfaceThickness) {
    if (b.y < a.y) return;
    // Using integers greatly reduces rendering time but looks worse
    if(fast) {
      rect(floor(a.x), floor(a.y), ceil(b.x-a.x), min(ceil(b.y-a.y), maxSurfaceThickness));
    } else {
      rect(a.x, a.y, b.x-a.x, min(b.y-a.y, maxSurfaceThickness));
    }
  }

  // Pass PVector reference to avoid creating new PVectors all the time
  private void project(PVector p, int flatX, int flatY, float flatZ) {
    // iso
    float px = (tData.tSize + flatX - flatY) * 0.5;
    float py = (flatX + flatY) * 0.5;

    float z = tData.tSize * 0.5 - flatZ + py * 0.75;
    float x = (px - tData.tSize / 2) * 6;
    float y = (tData.tSize - py) * 0.005 + 1;

    p.x = width / 2 + x/y;
    p.y = height / 5 + z/y;
  }
}

