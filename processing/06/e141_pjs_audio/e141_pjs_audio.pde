interface JavaScript {
  void playSound0();
  void playSound1();
}
void bindJavascript(JavaScript js) {
  javascript = js;
}
JavaScript javascript;

int x, dx;
void setup() {
  size(200, 200);
  noStroke();
  x = 20;
  dx = 2;
}
void draw() {
  background(100);
  fill(random(255),0,0);
  rect(x, 0, 5, height);
  x = x + dx;
  if(x < 1) {
    if(javascript != null) {
      javascript.playSound0();
    }
    x = 0;
    dx = 2;
  }
  if(x > width) {
    if(javascript != null) {
      javascript.playSound1();
    }
    x = width;
    dx = -3;    
  }  
}

