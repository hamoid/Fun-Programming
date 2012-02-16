// What is a global variable? A local variable? Scope?

// Global variable
float a = 1;

void my_test() {
  // Local variable called b. 
  // This variable can't be accessed in other functions
  float b = 77;
  println(a);
  println(b);
}

void setup() {
  // Local variable called b. 
  // This variable can't be accessed in other functions.
  float b = 2;
  
  println(a);
  println(b);
  my_test();
  println(b);
}

// You can have local variables with the same name in different functions.
// It's like having two persons with the same name: they are different persons!
