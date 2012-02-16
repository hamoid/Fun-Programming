float my_num = 0;
 
void setup() {
  size(400, 400);
}
 
void draw() {
  background(255 * noise(my_num + 100));
  stroke(255);
 
  // noise() returns a number between 0 and 1
  // when we multiply noise() by width, we get a number between 0 and width
  float x = noise(my_num) * width;
  // draw a vertical line
  line(x, 0, x, height);
 
  // we add 40 to my_num to avoid getting the exact same random number
  // we got on our previous call to the noise() function
  float y = noise(my_num + 40) * height;  
  // draw a horizontal line
  line(0, y, width, y);
  
  my_num = my_num + 0.02;
}
 
