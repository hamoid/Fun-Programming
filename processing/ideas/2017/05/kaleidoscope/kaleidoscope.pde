import java.io.FilenameFilter;
import processing.video.*;

Movie movie;
PShader fx;

void setup() {
  size(800, 400, P2D);
  noStroke();
  loadMovie();
  textureMode(NORMAL);
  fx = loadShader("fx.frag", "fx.vert");
}
void draw() {
  if (movie.available() == true) {
    movie.read();
    try {
      shader(fx);
    } catch(Exception e) {
      println(e);
    }
    beginShape();
    texture(movie);
    vertex(0, 0, 0, 0);
    vertex(width, 0, 1, 0);
    vertex(width, height, 1, 1);
    vertex(0, height, 0, 1);
    endShape();
  }
}
void loadMovie() {
  if (movie != null) {
    movie.stop();
  }
  File f = new File("/home/funpro/Videos/2016");
  File[] files = f.listFiles(new FilenameFilter() {                                                                                                                      
    public boolean accept(File dir, String name) {
      return name.toLowerCase().endsWith(".mp4");
    }
  }
  );

  movie = new Movie(this, files[(int)random(files.length)].getAbsolutePath());
  movie.loop();
}
void keyPressed() {
  if (key == 's') {
    save("thumb.jpg");
  }
  if (key == ' ') {
    loadMovie();
  }
  if (key == ENTER) {
      fx = loadShader("fx.frag", "fx.vert");
  }
}
