// Function declarations begin with 
// "void" when they return no value. 

// Function declarations begin with "float" if they 
// return a float value. In this case they include 
// a "return" statement.

// A float is a number with decimals, like 1.23 5.23 88.9
// An int is a number without decimals (integer), like 1, 2, 3

// --- Function 1
// Does not return any value.
// Does not take parameters.
void hello() {
  println("Hello!");
}

// --- Function 2
// Does not return any value.
// Takes two float parameters.
void print_sum(float a, float b) {
  println(a + b);
}

// --- Function 3
// Returns a float value.
// Takes two float parameters.
float calculate_sum(float a, float b) {
  float c = a + b;
  return c;
}

void setup() {
  // Call function 1
  // Similar to noStroke() and noFill()
  hello();
  
  // Call function 2
  // Similar to background(255) and line(0, 0, 10, 10)
  print_sum(10, 10);
  
  // Call function 3
  // Similar to random(10, 50)
  float my_added_numbers = calculate_sum(100, 50);
  println(my_added_numbers);
}
