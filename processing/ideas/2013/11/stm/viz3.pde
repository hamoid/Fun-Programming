/*
  3. Histogram
*/
void viz3() {
  background(255);
  stroke(255);
  fill(0);
  
  float bandWidth = width / float(data.histogram.length);
  for (int i=0; i<data.histogram.length; i++) {
    rect(i*bandWidth, height-height*data.histogram[i], bandWidth, height);
  }
   
  rendered = true;
}
