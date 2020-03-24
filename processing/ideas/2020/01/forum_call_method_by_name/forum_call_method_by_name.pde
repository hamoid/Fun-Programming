import java.lang.reflect.Method;

/*
  In the Processing forum it was asked how to call a method
  by name. Here's one example using reflection.
*/

// This variable contains the method to call on every
// animation frame
Method method;

void setup() {
  size(400, 400);
  
  // When the program starts we specify which function
  // we want to call initially
  setMethod("DrawCircle");
}

// A method to set the `method` variable by specifying
// a function name.
void setMethod(String name) {
  try {    
    method = this.getClass().getDeclaredMethod(name);
  } 
  catch(Exception e) {
    e.printStackTrace();
  }
}

void draw() {
  try {
    // try call whatever method we requested
    method.invoke(this);
  } 
  catch(Exception e) {
    e.printStackTrace();
  }
  
  // Specify a different method when we reach frame 150
  if(frameCount == 150) {
    setMethod("DrawRect");
  }
}

// The first method we will call, drawing circles
void DrawCircle() {
  fill(random(255));
  ellipse(random(width), random(height), 50, 50);
}

// The second method we will call, drawing rectangles
void DrawRect() {
  fill(random(255), random(255), random(255));
  rect(random(width), random(height), 50, 5);
}
