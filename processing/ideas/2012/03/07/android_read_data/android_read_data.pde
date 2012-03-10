// Android test, read a remote xml file, parse

import proxml.*;

XMLInOut xmlInOut;

void setup() {
  colorMode(HSB, 1);
  background(random(1), 1, 1);

  xmlInOut = new XMLInOut(this);
  xmlInOut.loadElement("http://www.w3schools.com/xml/note.xml");
}

void xmlEvent(XMLElement element) {
  for(int i = 0; i < element.countChildren();i++){
    print(element.getChild(i));
  }
}
