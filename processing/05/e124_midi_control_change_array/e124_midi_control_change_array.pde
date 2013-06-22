// This program only runs inside the
// Processing IDE, not in the browser.

import themidibus.*;

// An array where to store the last value received for each knob
float cc[] = new float[256];

MidiBus myBus;

void setup() {
  size(400, 400);
  background(255);
  
  // List all our MIDI devices
  MidiBus.list();
  
  // Connect to one of the devices
  myBus = new MidiBus(this, 0, 1);
}
void draw() {
  background(255);
  
  // Set the color depending on three knobs
  // You probably have to change the controller
  // numbers (99, 100 and 101) depending on the
  // controller you own
  fill(cc[99]*255, cc[100]*255, cc[101]*255);
  
  // Make the size of the circle depend on one of the knobs
  // Also, make the size oscillate. The oscillation speed depends on
  // another knob.
  float sz = cc[102] * 50 * sin(frameCount / map(cc[98], 0, 1, 10, 100));
  
  // Draw an ellipse. Two knobs define the position of the ellipse.
  ellipse(cc[104]*width, cc[103]*height, sz, sz);
}
// This function is called each time a knob, slider or button is pressed
// in the MIDI controller. It's up to us to do something interesting 
// with the received values. 
void controllerChange(int channel, int number, int value) {
  // Here we print the controller number.
  // The number that gets printed is the number we have to use
  // when accessing the cc[] array. Above we use numbers like
  // 98, 99, 100, 101, 102, 103 and 104. Those numbers are
  // specific to each controller.
  println(number);
  cc[number] = map(value, 0, 127, 0, 1);
}

