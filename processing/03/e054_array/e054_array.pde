background(0);
fill(255);

// Array

String[] nouns = {"forest", "tree", "flower", "sky", "grass", "mountain"}; 
String[] adjectives = {"happy", "rotating", "red", "fast", "elastic", "smily", "unbelievable", "infinite"};

int n = int(random(6)); // random number between 0 and 5
int m = int(random(8));

text(nouns[n], 10, 50);
text(adjectives[m], 10, 30);
