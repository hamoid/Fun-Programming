import com.hamoid.*;
import processing.video.*;

Capture cam;
VideoExport vcam;
PShader fx;
void setup() {
  size(640, 480, P2D);
  textAlign(CENTER, CENTER);
  frameRate(30);
  cam = new Capture(this, Capture.list()[1]);
  cam.start();
  fx = loadShader("fx.frag");
}
void draw() {
  if (cam.available()) {
    cam.read();
  }
  fx.set("time", millis() * 0.001);
  image(cam, 0, 0, width, height);
  filter(fx);
  if (vcam != null) { vcam.saveFrame(); }
  if (frameCount % 30 == 0) { fx = loadShader("fx.frag"); }  
}
void keyPressed() {
  if (key == ' ') {
    vcam = new VideoExport(this);
    vcam.setFfmpegVideoSettings(
      new String[]{
      "[ffmpeg]", // ffmpeg executable
      "-s", "640x480", // size
      "-r", "30", // frame rate
      "-f", "rawvideo", // format rgb raw
      "-vcodec", "rawvideo", // in codec rgb raw
      "-pix_fmt", "rgb24", // pix format rgb24
      "-i", "-", // pipe input
      "-vf",       "hflip",             // horizontal flip
      "-f", "v4l2", // format rgb raw
      "-vcodec", "rawvideo", // in codec rgb raw
      "-pix_fmt", "rgb24", // pix format rgb24    
      "/dev/video4" // $ v4l2-ctl --list-devices # find output device
      });
    vcam.startMovie();
  }
}
