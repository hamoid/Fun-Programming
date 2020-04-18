int n = 55;

void setup() {
  frameRate(1); // make the movie run very slow. 1 frame per second


  println("This is a while loop that counts up to 9");
  
  int a = 0;
  while(a < 10) {
    print(a);
    a++;
  }
  
  println(); // print an empty line
  
  
  println("This is a for loop that counts up to 9");
  
  for (int b = 0; b < 10; b++) { // like a while loop, but less typing!
    print(b);
  }  

  println();
  println();

  println("n is " + n);
  
  n++;  // short version of n = n + 1;
  println("after n++; n is " + n);

  n--; // short version of n = n - 1;
  println("after n--; n is " + n);
  
  n += 3; // short version of n = n + 3;
  println("after n += 3; n is " + n);

  println();  
}

void draw() {
  // when you need a counter, you can use frameCount:
  println("frameCount is " + frameCount);
  
  if(frameCount > 3) {
    noLoop(); // stop after four frames
  }
}
