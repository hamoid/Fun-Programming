import java.io.*;

// A program that executes a command line program, and pipes the program's
// output back into Processing.

// 17.07.2016 Abe Pazos - http://funprogramming.org

BufferedReader reader;
ProcessBuilder processBuilder;
Process process;

void setup() {
  fullScreen();
  background(0);
  textAlign(CENTER, CENTER);
  
  // This could be any command. In this case I'm just listing
  // all the files in the hard drive.
  processBuilder = new ProcessBuilder("ls", "-R", "/");
  processBuilder.redirectInput(ProcessBuilder.Redirect.PIPE);
  try {
    process = processBuilder.start();
    reader = new BufferedReader(new InputStreamReader(process.getInputStream()));
    
    // We could try to read the whole output here. But if the output is huge (like the
    // listing of all files in the hard drive) or takes a long time to produce (network access)
    // it will be stuck here for a long time, without updating the screen. It will seem like it 
    // crashed. That's why I prefer to read line by line inside the draw() function.
    
    // while((s = reader.readLine()) != null) {
    //   println(s);
    // }
  }
  catch (Exception e) {
    e.printStackTrace();
  }
}

void draw() {
  try {
    String s;
    if ((s = reader.readLine()) != null) {
      fill(frameCount % 256);
      textSize((1 + frameCount % 8) * 10);
      text(s, (frameCount / 20) * (height / 20) % width, (frameCount % 20) * (width / 20));
    }
  } 
  catch(Exception e) {
    e.printStackTrace();
  }
}