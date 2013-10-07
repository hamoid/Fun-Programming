import processing.serial.*;
import cc.arduino.*;

Arduino arduino;

String[] leds = {
  "....*.....*****....***........***...*...*...*****...*.......***.....***.....*****...*...*..",
  "...**.........*...*...*......*......*...*.....*.....*.......*..*....*..*....*.......**..*..",
  "..*.*........*.....***......*.......*****.....*.....*.......*...*...*..*....***.....*.*.*..",
  "....*.......*.....*...*.....*.......*...*.....*.....*.......*...*...***.....*.......*..**..",
  "....*......*......*...*......*......*...*.....*.....*.......*..*....*..*....*.......*...*..",
  "..*****...*........***........***...*...*...*****...*****...***.....*...*...*****...*...*..",
};
int w;
int pos = 0;

void setup() {  
  arduino_setup();
  w = leds[0].length();
  frameRate(10);
}
void arduino_setup() {
  println(Arduino.list());
  arduino = new Arduino(this, Arduino.list()[1], 57600);
  
  for (int i = 0; i <= 13; i++) {
    arduino.pinMode(i, Arduino.OUTPUT);
    arduino.digitalWrite(i, Arduino.LOW);
  }
}

void draw() {
  if(frameCount == 20) {
    arduino.digitalWrite(11, Arduino.HIGH);
  }
  if(frameCount == 21) {
    arduino.digitalWrite(11, Arduino.LOW);
  }
  if(frameCount < 32) {
    return;
  }
  for (int i = 5; i >= 0; i--) {
    if(leds[i].charAt(pos) == '*') {
      arduino.digitalWrite(13-i, Arduino.HIGH);
    } else {
      arduino.digitalWrite(13-i, Arduino.LOW);
    }
  }
  println();
  if(++pos >= w) {
    noLoop();
  }
}

