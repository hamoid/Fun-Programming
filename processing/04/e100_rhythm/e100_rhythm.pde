import ddf.minim.*;

Minim soundengine;
AudioSample s1;
AudioSample s2;
AudioSample s3;
AudioSample s4;
int[] when = {0, 16, 24, 32};

void setup() {
  soundengine = new Minim(this);
  s1 = soundengine.loadSample("2.wav", 1024);
  s2 = soundengine.loadSample("3.wav", 1024);
  s3 = soundengine.loadSample("4.wav", 1024);
  s4 = soundengine.loadSample("5.wav", 1024);
}
void draw() {
  if(frameCount % 64 == when[0]) {
    s1.trigger();
  }
  if(frameCount % 64 == when[1]) {
    s2.trigger();
  }
  if(frameCount % 64 == when[2]) {
    s3.trigger();
  }
  if(frameCount % 64 == when[3]) {
    s4.trigger();
  }
  if(random(100) > 99) {
    int which = int(random(4));
    when[which] = 8 * int(random(8));
  }
}
void stop() {
  s1.stop();
  s2.stop();
  s3.stop();
  s4.stop();
  soundengine.stop();
  super.stop();
}

