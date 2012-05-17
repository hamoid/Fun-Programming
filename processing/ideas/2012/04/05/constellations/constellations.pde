int N = 200;
float[] x = new float[N];
float[] y = new float[N];
float[] a = new float[N];
float[] c = new float[N];
float[] flashing = new float[N];

int from;
int to;

float[] colors = { 
  200, 160, 120, 80
};

void setup() {
  size(400, 400);
  noStroke();
  smooth();

  for (int i = 0; i<N; i++) {
    x[i] = random (0, width);
    y[i] = random (height);
    a[i] = random (TWO_PI);
    flashing[i] = 0;
    c[i] = choose1float(colors);
  }
  from = int(random(x.length));
  to = int(random(x.length));
}

void draw() {
  background(#021129);
  for (int i = 0; i<N; i++) {
    if (flashing[i] > 0) {
      fill(c[i], 128);
      float r = 5*sin(flashing[i]);
      ellipse(x[i], y[i], r, r);
      flashing[i] -= 0.1;
    } 
    else {
      if (random(10000) > 9993) {
        flashing[i] = PI;
      }
    }

    fill(c[i], 128);
    ellipse(x[i], y[i], 2, 2);

    a[i] = a[i] + random(-0.1, 0.1);

    float distance = noise(x[i]/100.0, y[i]/100.0, frameCount/100.0) - 0.1;
    x[i] = x[i] + sin(a[i]) * distance ;
    y[i] = y[i] + cos(a[i]) * distance ;

    if (x[i] > width) {
      x[i] = 0;
    }
    if (x[i] < 0) {
      x[i] = width;
    }

    if (y[i] > height) {
      y[i] = 0;
    }
    if (y[i] < 0) {
      x[i] = height;
    }
  }
  if(random(1000)> 990) {
    from = int(random(x.length));
  }
  if(random(1000)> 990) {
    to = int(random(x.length));
  }
  stroke(255, random(15,30));
  line(x[from], y[from], x[to], y[to]);
  noStroke();
}

float choose1float(float[] arr) {
  return arr[int(random(arr.length))];
}

