class ColorPair {
  color fg, bg;

  ColorPair() {
    bg = color(random(255), random(100), random(255));
    fg = opposite(bg);
  }
  color opposite(color c) {
    return color( (hue(c)+128)%256, random(50,100), (brightness(c)+128)%256 );
  }
  void displace(int r) {
    float h = r * random(0.9, 1.1) * (random(1)>0.5 ? -1 : 1); 
    float b = r * random(0.9, 1.1) * (random(1)>0.5 ? -1 : 1); 
    bg = color(
      (hue(bg) + h + 256) % 256, 
      random(50,100), 
      constrain(brightness(bg) + b, 0, 255)
    );
    fg = opposite(bg);
  }
}

