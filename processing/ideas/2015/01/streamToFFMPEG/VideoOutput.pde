import java.io.*;

/*

  Class to stream Processing frames directly to a video file. 
  
  Tested only in 1 computer, 1 OS (Arch Linux), 1 time. I swear it worked :)
  
  It will have to be cleaned up and adapted to other OSes.
  
  It would be great to have this as part of Processing by default.
  
  By Abe Pazos on his 40th birthday :)
  
*/

// Quality settings. 
// -qp 0 means losless
// -crf 23 is the default
// Lower crf means better quality
// http://slhck.info/articles/crf
// https://trac.ffmpeg.org/wiki/Encode/H.264
// https://video.stackexchange.com/questions/10463/h264-settings-for-large-flat-areas-of-slowly-changing-colour

class VideoOutput {
  File ffmpeg_output_msg;
  ProcessBuilder pb;
  Process p;
  OutputStream ffmpegInput;
  byte[] pixelsByte;
  PGraphics pg;

  public VideoOutput(PGraphics pg, String path, String filename, int framerate) {
    this.pg = pg;

    ffmpeg_output_msg = new File(path + "/" + filename + ".txt");

    pb = new ProcessBuilder(
    "ffmpeg", 
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
    sketchPath + "/" + filename);

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
    pg.loadPixels();
    for (int i=0; i<pg.pixels.length; i++) {
      final int px = pg.pixels[i];
      final int i3 = i * 3;
      pixelsByte[i3] = (byte)(px >> 16);
      pixelsByte[i3 + 1] = (byte)(px >> 8);
      pixelsByte[i3 + 2] = (byte)(px);
    }
    try {
      ffmpegInput.write(pixelsByte);
    } 
    catch( Exception e) {
      e.printStackTrace();
      err();
    }
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
