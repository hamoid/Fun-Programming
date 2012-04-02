class Car {
  float x;
  float y;
  color c;
  
  Car(float carx, float cary, color carcolor) {
    x = carx;
    y = cary;
    c = carcolor;
  }
  void drive(int speed) {
    x = x + speed;
    fill(c);
    rect(x, y, 40, 10);
  }
}
