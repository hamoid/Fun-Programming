// Run this program only in the Java mode inside the IDE,
// not on Processing.js (web mode)!!

byte data[] = loadBytes("/PATH/TO/YOUR/FILE/3493058.png");

size(600, 100);
colorMode(HSB);

for(int i=0; i<width; i++) {
  int myhue = data[i] & 0xff;
  stroke(myhue, 255, 255);
  line(i,0,i,height);
}

print(127 & 0xff);
