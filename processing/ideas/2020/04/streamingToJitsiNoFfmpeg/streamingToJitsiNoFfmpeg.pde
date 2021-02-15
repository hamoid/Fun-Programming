import java.nio.ByteBuffer;
import java.io.FileOutputStream;
import com.hamoid.*;

FileOutputStream vcam;
byte[] bytes;

void setup() {
  size(640, 480, P3D);
  textAlign(CENTER, CENTER);
  textFont(loadFont("PetMe64-48.vlw"));
  stroke(255, 180);
  strokeWeight(4);
  sphereDetail(3);
  try {
    vcam = new FileOutputStream("/dev/video2");
  } catch(Exception e) {
    e.printStackTrace();
  }
  bytes = new byte[640 * 480 * 3];
}
void draw() {
  hint(DISABLE_DEPTH_TEST);
  background(#224488);
  noFill();
  translate(width/2, height/2);
  rotateY(frameCount * 0.01);
  sphere(300);
  rotateY(-frameCount * 0.01);
  textSize(50 + 15*sin(frameCount * 0.1));
  fill(255, 180);
  text("hello jitsi", 0, 0);
  
  loadPixels();
  for(int i=0; i<pixels.length; i++) {
    int x = i % 640;
    int y = i / 640;
    int ii = 639 - x + y * 640;
    bytes[i * 3 + 0] = (byte)(pixels[ii] >> 16);  
    bytes[i * 3 + 1] = (byte)(pixels[ii] >> 8);  
    bytes[i * 3 + 2] = (byte)(pixels[ii]);  
  }
  
  try {
    vcam.write(bytes);
  } catch(IOException e) {
    e.printStackTrace();
  }
}
