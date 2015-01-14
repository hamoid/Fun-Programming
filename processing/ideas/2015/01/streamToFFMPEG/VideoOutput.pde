import java.io.*;

/*

  Processing VideoOutput v0.0.1

  Class to stream Processing frames directly to a video file. 
  
  Tested on Arch Linux. 
  Please let me know if it works on other systems.
  
  It needs ffmpeg installed (video manipulation command line program).
  
  On Mac you can get ffmpeg by installing the Homebrew
  package manager (http://brew.sh) and then typing 
  
    brew install ffmpeg
  
  in the terminal.
   
  By Abe Pazos - http://funprogramming.org
  
*/

// ffmpeg quality settings:
// Both -qp and -crf affect quality. 
// -qp 0 means losless
// -crf 23 is the default. Lower values increase quality.
// http://slhck.info/articles/crf
// https://trac.ffmpeg.org/wiki/Encode/H.264
// https://video.stackexchange.com/questions/10463/h264-settings-for-large-flat-areas-of-slowly-changing-colour

class VideoOutput {
  private File ffmpeg_output_msg;
  private ProcessBuilder pb;
  private Process p;
  private OutputStream ffmpegInput;
  private byte[] pixelsByte;
  private PGraphics pg;
  private boolean loadPixelsEnabled = true;

  public VideoOutput(PGraphics pg, String path, String filename, float framerate) {
    this.pg = pg;

    ffmpeg_output_msg = new File(path + "/" + filename + ".txt");

    pb = new ProcessBuilder(
    "ffmpeg", // path to ffmpeg. In Windows probably ffmpeg.exe 
    "-y", // overwrite, otherwise it fails the second time you run it
    "-f", "rawvideo", 
    "-vcodec", "rawvideo", 
    "-s", pg.width + "x" + pg.height, 
    "-pix_fmt", "rgb24", 
    "-r", "" + framerate, 
    "-i", "-", // pipe:0 
    "-an", // no audio
    "-vcodec", "h264", 
    "-crf", "15", 
    //"-b:v", "3000k", // video bit rate
    path + "/" + filename);

    pb.redirectErrorStream(true);
    pb.redirectOutput(ffmpeg_output_msg);
    pb.redirectInput(ProcessBuilder.Redirect.PIPE);
    try {
      p = pb.start();
    } 
    catch (Exception e) {
      e.printStackTrace();
      err();
    }

    ffmpegInput = p.getOutputStream();

    pixelsByte = new byte[pg.width * pg.height * 3];
  }
  public void saveFrame() {
    if(loadPixelsEnabled) {
      pg.loadPixels();
    }
    int byteNum = 0;
    for (int i=0; i<pg.pixels.length; i++) {
      final int px = pg.pixels[i];
      pixelsByte[byteNum++] = (byte)(px >> 16);
      pixelsByte[byteNum++] = (byte)(px >> 8);
      pixelsByte[byteNum++] = (byte)(px);
    }
    try {
      ffmpegInput.write(pixelsByte);
    } 
    catch( Exception e) {
      e.printStackTrace();
      err();
    }
  }
  public void setLoadPixelsEnabled(boolean enabled) {
    loadPixelsEnabled = enabled;
  }
  public void close() {
    try {
      ffmpegInput.flush();
      ffmpegInput.close();
    } 
    catch (Exception e) {
      e.printStackTrace();
    }
    p.destroy();
  }
  private void err() {
    println("Check", ffmpeg_output_msg, "to find out what went wrong");
    exit();
  }
}
