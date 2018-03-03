import java.util.Collection;
import javax.sound.midi.*;

AMidiPlayer midiPlayer;
PShader shader;

void setup() {
  fullScreen(P3D);
  background(0);
  colorMode(HSB);
  noStroke();
  midiPlayer = new AMidiPlayer();
  midiPlayer.load(dataPath("pianocon.mid"));
  midiPlayer.start();
  shader = loadShader("shader.glsl");
}

void draw() {
  //background(#112244);
  shader.set("n", 20 * noise(frameCount * 0.001));

  translate(width/2, height/2);
  rotateZ(noise(0.23, 15 * frameCount * 0.00013));
  rotateY(frameCount * 0.003);

  directionalLight(30, 20, 255, 1, 1, 1);
  directionalLight(150, 20, 255, -1, -1, -1);
  
  for (Note n : midiPlayer.getNotes()) {
    fill(map(n.note % 12, 0, 11, 0, 255), 
      map(n.channel, 0, 15, 80, 255), 
      map(n.note, 0, 127, 100, 255) * random(0.9, 1.0));

    pushMatrix();
    float t = frameCount * 0.003;
    scale(n.velocity * 0.05);
    rotateX(n.channel + noise(n.note * 0.1, t));
    rotateY(n.note * 0.06);
    rotateZ(map(n.note % 12, 0, 12, 0, TWO_PI));
    pushMatrix();
    translate(0, n.velocity * 0.7, 0);
    box(40.0 / n.living, n.velocity * 0.1 + random(10), 40.0 / n.living);
    popMatrix();    
    translate(0, 5000.0, 0);
    box(0.2, 10000, 0.2);
    popMatrix();
  }
  midiPlayer.update();
}