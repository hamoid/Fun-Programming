void write_word(String[] words) {
  int n = int(random(words.length));
  print(words[n]);
  print(" ");
}
void setup() {
  background(255);
  fill(255);

  // this happy tree is thinking above one smily ocean

  String[] art = {
    "this", "that", "one", "the"
  };
  String[] nou = {
    "forest", "tree", "flower", "sky", "grass", "mountain"
  }; 
  String[] adj = {
    "happy", "rotating", "red", "fast", "elastic", "smily", "unbelievable", "infinte", 
    "intelligent", "shy"
  };
  String[] ver = {
    "runs", "is thinking", "was flying", "observes"
  };
  String[] pre = {
    "above", "inside", "behind", "in front of"
  };

  write_word(art);
  write_word(adj);
  write_word(nou);

  write_word(ver);
  write_word(pre);

  write_word(art);
  write_word(adj);
  write_word(nou);
}

