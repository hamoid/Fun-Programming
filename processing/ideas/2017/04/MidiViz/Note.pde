class Note {
  int channel;
  int note;
  int velocity;
  float life = 1.0;
  boolean done = false;
  Note(int c, int n, int v) {
    channel = c;
    note = n;
    velocity = v;
  }
}