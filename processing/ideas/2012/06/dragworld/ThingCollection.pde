class ThingCollection {
  Thing[] things;
  int amount;
  
  ThingCollection() {
    int sz = 40;
    int amtX = ((width+margin*2) / sz);
    int amtY = ((height+margin*2) / sz);
    int i = 0;
    float rSz = (width+margin*2) / float(amtX);
    amount = amtX * amtY;
    things = new Thing[amount];
    for(int x=0; x<amtX; x++) {
      for(int y=0; y<amtY; y++) {
        things[i++] = new Thing(x*rSz, y*rSz, rSz);
      }
    } 
  }
  
  void draw(int x, int y) {
    for(int i=0; i<amount; i++) {
      float nX = x + things[i].x;
      float nY = y + things[i].y;
      
      things[i].checkLimits(nX, nY);
      
      float a = atan2(nY-CY, nX-CX);
      float d = dist(CX, CY, nX, nY);
        
      things[i].setVector(d*cos(a), d*sin(a));
    }
    for(int n=0; n<10; n++) {
      for(int i=0; i<amount; i++) {
        things[i].draw(n);        
      }
    }    
  }
  void move(int x, int y) {
    for(int i=0; i<amount; i++) {
      things[i].move(x, y);
    }
  }
}
