// This program only runs inside the
// Processing IDE, not in the browser.

import themidibus.*;

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
}
// This function is called each time a knob, slider or button is pressed
// in the MIDI controller. It's up to us to do something interesting
// with the received values.
void controllerChange(int channel, int number, int value) {
  // Here we print the controller number.
  println(number);
  // If we turn knob with id 104, draw a line
  // The vertical position of the line depends on how much we turn the knob
  if(number == 104) {
    float y = map(value, 0, 127, 0, height);
    line(0, y, width, y);
  }
  // If we turn knob with id 103, draw a circle
  // The size of the circle depends on how much we turn the knob
  if(number == 103) {
    ellipse(width/2, height/2, value*2, value*2);
  }
}

