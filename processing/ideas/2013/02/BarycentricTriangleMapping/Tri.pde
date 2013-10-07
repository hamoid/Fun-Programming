class Tri {
  PVector A, B, C;

  Tri(float x0, float y0, float x1, float y1, float x2, float y2) {
    A = new PVector(x0, y0);
    B = new PVector(x1, y1);
    C = new PVector(x2, y2);
  }

  Tri() {
    A = new PVector(random(width/2), random(height/2));
    B = new PVector(random(width/2, width), random(height/2));
    C = new PVector(random(width), random(height/2, height));
  }
  
  PVector getXY(PVector uv) {
    PVector O = new PVector(A.x, A.y, A.z);  // P = A
    
    PVector P = PVector.sub(C, A);           // C-A
    P.mult(uv.x);                            // u*(C-A)
    O.add(P);                                // A + u*(C-A)
    
    P = PVector.sub(B, A);                   // B-A
    P.mult(uv.y);                            // v*(B-A)
    O.add(P);                                // A + u*(C-A) + v*(B-A)
    
    return O;
  }
  
  PVector getUV(PVector XY) {
    PVector AC = PVector.sub(C, A);
    PVector AB = PVector.sub(B, A);
    PVector AXY = PVector.sub(XY, A);
  
    float dotACAC = AC.dot(AC);
    float dotABAB = AB.dot(AB);
    float dotACXY = AC.dot(AXY);
    float dotABXY = AB.dot(AXY);
    float dotACAB = AC.dot(AB);
  
    float denom = dotACAC * dotABAB - dotACAB * dotACAB;
  
    float u = (dotABAB * dotACXY - dotACAB * dotABXY) / denom;
    float v = (dotACAC * dotABXY - dotACAB * dotACXY) / denom;    
    
    return new PVector(u, v);
  }
  
  void draw() {
    triangle(A.x, A.y, B.x, B.y, C.x, C.y);
  }
}

