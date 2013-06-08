// Run this program only in the Java mode inside the IDE,
// not on Processing.js (web mode)!!

byte data[] = loadBytes("3493058.png");

size(600, 100);
colorMode(HSB);

for(int i=0; i<data.length; i++) {
  int myhue = data[i] & 0xff;
  stroke(myhue, 255, 255);
  line(i,0,i,height);
}

print(127 & 0xff);
