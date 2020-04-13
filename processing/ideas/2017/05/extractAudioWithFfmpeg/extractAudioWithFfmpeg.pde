import java.io.InputStreamReader;

// ffmpeg should be found on your system, and be in the PATH

void setup() {
  // Create data folder if it doesn't exist
  (new File(dataPath(""))).mkdirs();

  try {
    String[] commands = {
      "ffmpeg", 
      "-i", 
      "/path/to/your/video.mp4", 
      dataPath("audio.mp3")
    };
    Process proc = exec(commands);

    BufferedReader stdInput = new BufferedReader(new 
      InputStreamReader(proc.getInputStream()));

    BufferedReader stdError = new BufferedReader(new 
      InputStreamReader(proc.getErrorStream()));

    println("# Command output");
    String s = null;
    while ((s = stdInput.readLine()) != null) {
      println(s);
    }

    println("# Command errors");
    while ((s = stdError.readLine()) != null) {
      println(s);
    }
  } 
  catch(Exception e) {
    println(e);
  }
}
void draw() {
}