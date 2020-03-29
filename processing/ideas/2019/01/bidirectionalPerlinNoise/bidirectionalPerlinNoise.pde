void setup() {
  size(1500, 1500, P2D);
  stroke(#E8E3D0, 50);
  background(#272524);
  noFill();
}

void draw() {
  float X = random(width);
  float Y = random(height);

  PShape A = getPath(X, Y, 1);
  PShape B = getPath(X, Y, -1);

  shape(A, 0, 0);  
  shape(A, width/3, 0); // draw both A and B in the center
  shape(B, width/3, 0); // draw both A and B in the center  
  shape(B, 2*width/3, 0);
}

PShape getPath(float x, float y, float sign) {
  boolean go = true;
  PShape shp = createShape();
  shp.beginShape();
  while (go) {
    shp.vertex(x, y);

    float d = 5;
    float k = 0.01; //0.03 * noise(y * 0.003, x * 0.003) - 0.03 * 0.3;
    float a = noise(x * k, y * k);
    a = doubleCircleSigmoid(a, 0.98);
    a *= TAU;

    x += sign * d * cos(a);
    y += sign * d * sin(a);

    if (x < 0 || x > width/3 || y < 0 || y > height) {
      go = false;
    }
  }
  shp.endShape();
  return shp;
}

void keyPressed() {
  if(key == 's') {
    save("thumb.jpg");
  }
}

float easeInOut(float t) {
  if ((t *= 2) < 1) {
    return 0.5 * t * t;
  }
  return -0.5 * ((--t) * (t - 2) - 1);
}

// Shaping functions from www.flong.com/texts/code/
float doubleExponentialSigmoid (float x, float a){
  float epsilon = 0.00001;
  float min_param_a = 0.0 + epsilon;
  float max_param_a = 1.0 - epsilon;
  a = min(max_param_a, max(min_param_a, a));
  a = 1.0-a; // for sensible results
  
  float y = 0;
  if (x<=0.5){
    y = (pow(2.0*x, 1.0/a))/2.0;
  } else {
    y = 1.0 - (pow(2.0*(1.0-x), 1.0/a))/2.0;
  }
  return y;
}

float doubleCircleSigmoid (float x, float a){
  float min_param_a = 0.0;
  float max_param_a = 1.0;
  a = max(min_param_a, min(max_param_a, a)); 

  float y = 0;
  if (x<=a){
    y = a - sqrt(a*a - x*x);
  } else {
    y = a + sqrt(sq(1-a) - sq(x-1));
  }
  return y;
}

float logisticSigmoid (float x, float a){
  // n.b.: this Logistic Sigmoid has been normalized.

  float epsilon = 0.0001;
  float min_param_a = 0.0 + epsilon;
  float max_param_a = 1.0 - epsilon;
  a = max(min_param_a, min(max_param_a, a));
  a = (1/(1-a) - 1);

  float A = 1.0 / (1.0 + exp(0 -((x-0.5)*a*2.0)));
  float B = 1.0 / (1.0 + exp(a));
  float C = 1.0 / (1.0 + exp(0-a)); 
  float y = (A-B)/(C-B);
  return y;
}
