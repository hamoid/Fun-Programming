// JavaScript binding, following http://processingjs.org/articles/PomaxGuide.html
// This allows us to call a JS function from processing.js
interface JavaScript {
  void saveRemoteImage(String url, String fname, String format);
}
void bindJavascript(JavaScript js) {
  javascript = js;
}
JavaScript javascript;


String scriptURL = "up.php";
String fileName = "circle.png";
boolean sent = false;

void setup() {  
  background(255, random(255), random(255));
  ellipse(random(100), 50, 50, 50);  
}

void draw() {
  // When javascript binding is ready (it may take some time)
  // and if the image was not yet uploaded, upload it now. 
  if(javascript != null && !sent) {
    sent = true;
    javascript.saveRemoteImage(scriptURL, fileName, "image/png");
  }
}

