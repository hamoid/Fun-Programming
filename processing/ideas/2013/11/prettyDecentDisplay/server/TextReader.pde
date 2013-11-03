class TextReader {
  int currentLine = 0;
  int currentChar = 0;
  int nextEventMillis = 0;
  String text[];
  ColorPair colors;

  TextReader(ColorPair c) {
    colors = c;
    text = loadStrings("words.txt");
  }
  String getLetter() {
    return "" + text[currentLine].charAt(currentChar);
  }
  void nextLetter() {
    if(++currentChar >= text[currentLine].length()) {
      nextLine();
    } else if(getLetter().equals(" ")) {
      nextWord();
    } else {
      nextEventMillis = millis() + 100;
      colors.displace(10);
    }
  }
  void nextWord() {
    nextEventMillis = millis() + 500;
    colors.displace(45);
  }
  void nextLine() {
    currentChar = 0;
    currentLine = (currentLine + 1) % text.length;
    nextEventMillis = millis() + 2000;
    colors.displace(90);
  }
}

