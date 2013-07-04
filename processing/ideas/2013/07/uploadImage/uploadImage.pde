/*
  Processing + PHP code to upload images to a web server
  
  Based on: http://wiki.processing.org/index.php?title=Saving_files_to_a_web_server&oldid=482
  
  Updated on 04.07.2013 by Abe Pazos - http://funprogramming.org
  
  Tested with Processing 2.0 and PHP 5.3.10
  
  This file can upload PImage, byte[] and String content to the server.
*/

import java.net.*;
import java.io.*;

// Change this to the URL of the PHP script on your server
String scriptURL = "http://w/index.php";

String TMPFNAME = "_tmp_file_to_upload";

void setup() {  
  // Example 1. Upload current image as a PNG or JPG
  background(255, 0, 0);
  ellipse(50, 50, 50, 50);
  saveToWeb("circle.png");
  
  // Example 2. Upload a PImage as PNG or JPG
  //PImage img = createImage(66, 66, RGB);
  //img.loadPixels();
  //for (int i = 0; i < img.pixels.length; i++)
  //  img.pixels[i] = color(random(255)); 
  //img.updatePixels(); 
  //saveToWeb("random.png", img);
  
  // Example 3. Upload bytes
  //byte[] someBytes = { 65, 66, 67, 68, 69 };
  //saveToWeb("bytes.txt", someBytes);
  
  // Example 4. Upload a string
  //String aString = "Once\nupon\na\ntime\n...";
  //saveToWeb("text.txt", aString);
}

void saveToWeb(String filename, String txt) {
  postData(filename, "text/plain", txt.getBytes());
}
void saveToWeb(String filename, byte[] data) {
  postData(filename, "application/octet-stream", data);
}
void saveToWeb(String filename, PImage img) {
  PGraphics pg = createGraphics(img.width, img.height);
  pg.image(img, 0, 0);
  // TODO: encode jpg/png without saving to disk 
  if(isJPG(filename)) {
    pg.save(TMPFNAME + ".jpg");
    postData(filename, "image/jpeg", loadBytes(TMPFNAME + ".jpg"));
  }
  if(isPNG(filename)) {
    pg.save(TMPFNAME + ".png");
    postData(filename, "image/png", loadBytes(TMPFNAME + ".png"));
  }
}
void saveToWeb(String filename) {
  // TODO: encode jpg/png without saving to disk 
  if(isJPG(filename)) {
    save(TMPFNAME + ".jpg");
    postData(filename, "image/jpeg", loadBytes(TMPFNAME + ".jpg"));
  }
  if(isPNG(filename)) {
    save(TMPFNAME + ".png");
    postData(filename, "image/png", loadBytes(TMPFNAME + ".png"));
  }
}
void postData(String filename, String ctype, byte[] bytes) {
  try {
    URL u = new URL(scriptURL);
    URLConnection c = u.openConnection();
    // post multipart data

    c.setDoOutput(true);
    c.setDoInput(true);
    c.setUseCaches(false);

    // set request headers
    c.setRequestProperty("Content-Type", "multipart/form-data; boundary=AXi93A");

    // open a stream which can write to the url
    DataOutputStream dstream = new DataOutputStream(c.getOutputStream());

    // write content to the server, begin with the tag that says a content element is coming
    dstream.writeBytes("--AXi93A\r\n");

    // describe the content
    dstream.writeBytes("Content-Disposition: form-data; name=p5uploader; filename=" + filename + 
      " \r\nContent-Type: " + ctype + 
      "\r\nContent-Transfer-Encoding: binary\r\n\r\n");
    dstream.write(bytes, 0, bytes.length);

    // close the multipart form request
    dstream.writeBytes("\r\n--AXi93A--\r\n\r\n");
    dstream.flush();
    dstream.close();

    // print the response
    try {
      BufferedReader in = new BufferedReader(new InputStreamReader(c.getInputStream()));
      String responseLine = in.readLine();
      while (responseLine != null) {
        println(responseLine);
        responseLine = in.readLine();
      }
    }
    catch(Exception e) {
      e.printStackTrace();
    }
  }
  catch(Exception e) { 
    e.printStackTrace();
  }
}
boolean isJPG(String filename) {
  return filename.toLowerCase().endsWith(".jpg") || filename.toLowerCase().endsWith(".jpeg");
}
boolean isPNG(String filename) {
  return filename.toLowerCase().endsWith(".png");
}

