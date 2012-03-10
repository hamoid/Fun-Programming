// This sketch has been tested in Processing 2.0a4

// Android SDK was installed as described at
// http://wiki.processing.org/w/Android
// In that page, note the part that says Processing 2.0 is required

// Remember to use "Run on Device" 
// (CTRL + SHIFT + R  or  SHIFT + click on play)

import apwidgets.*;

APMediaPlayer player;

void setup() {
  player = new APMediaPlayer(this);
}

void draw() {
}

void mousePressed() {
  if(mouseY > height / 2) {
    player.setMediaFile("test2.mp3");
  } else {
    player.setMediaFile("test.mp3");
  }
  player.start();
}

public void onDestroy() {
  super.onDestroy(); 
  if(player != null) { 
    player.release();
  }
}
