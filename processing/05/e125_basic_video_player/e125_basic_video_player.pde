// Note: this program runs only in the Processing IDE, not in the browser
import processing.video.*;

String PATH = "/path/to/one/of/your/movies/blabla.mp4";
Movie mov;

void setup() {
  size(640, 360);
  frameRate(30);
  mov = new Movie(this, PATH);
  mov.play();
  mov.speed(5);
  mov.volume(0);
}
void movieEvent(Movie m) {
  m.read();
}
void draw() {
  image(mov, 0, 0, width, height);
}
