import java.util.concurrent.ConcurrentHashMap;
import javax.sound.midi.*;

AMidiPlayer midiPlayer;

// Concurrent, so it can be accessed by the Processing main thread, and the
// midi player thread without crashing.
ConcurrentHashMap<Integer, Note> playingNotes = new ConcurrentHashMap<Integer, Note>();

void setup() {
  fullScreen(P3D);
  background(0);
  colorMode(HSB);
  noStroke();
  midiPlayer = new AMidiPlayer(playingNotes);
  midiPlayer.setup(dataPath("pianocon.mid"));
  midiPlayer.start();
}

void draw() {
  background(#112244);

  translate(width/2, height/2);
  rotateZ(noise(0.23, 15 * frameCount * 0.00013));
  rotateY(frameCount * 0.003);

  directionalLight(30, 20, 255, 1, 1, 1);
  directionalLight(150, 20, 255, -1, -1, -1);

  for (Note n : playingNotes.values()) {
    fill(map(n.note % 12, 0, 11, 0, 255), 
      map(n.channel, 0, 15, 80, 255), 
      map(n.channel, 0, 15, 250, 160) * random(0.9, 1.0));

    pushMatrix();
    float t = frameCount * 0.003;
    scale(n.velocity * 0.05);
    rotateX(n.channel + noise(n.note * 0.1, t));
    rotateY(n.note * 0.06);
    rotateZ(n.channel - noise(n.note * 0.1, t) + n.note * 0.02);
    pushMatrix();
    translate(0, n.velocity * 0.7, 0);
    box(10 * n.life, n.velocity, 10 * n.life);
    popMatrix();
    translate(0, 5000, 0);
    box(0.2, 10000, 0.2);
    popMatrix();
    if(n.done) {
      midiPlayer.fade(n);
    }
  }
}