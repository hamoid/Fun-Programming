Car[] cars = new Car[100];

void setup() {
  size(500, 400);
  for(int i=0; i<cars.length; i++) {
    cars[i] = new Car(20, random(height), #0AA8F5);
  }
}
void draw() {
  background(255);
  for(int i=0; i<cars.length; i++) {
    cars[i].drive(i);
  }
}
