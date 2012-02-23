void setup() {
  size(400, 400);
  background(#FFB81F);
  frameRate(1);  
  textSize(20);    
}
void draw() {
  background(#FFB81F);

  String message = "Date: " + day() + "." + month() + "." + year(); 
  text(message, 100, 100);

  message = "Time: " + nf(hour(), 2) + ":" + nf(minute(), 2) + ":" + nf(second(), 2); 
  text(message, 100, 130);

  message = "A simple sentence";
  println(message.charAt(0)); // print one character from a string
  
  println(message.indexOf("t")); // find the position of letter "t" inside a string
}
