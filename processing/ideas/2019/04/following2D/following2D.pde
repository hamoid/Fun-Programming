Follower2D follower;

void setup() {
  size(800, 800, P2D);
  smooth(8);

  follower = new Follower2D();
  follower.setCurrent(random(width), random(height));
  follower.setTarget(random(width), random(height));
  follower.setDecelerateDistance(100);
  follower.setLerpSpeed(0.01);
}

void draw() {
  background(40);

  noStroke();
  fill(255);
  follower.update();
  circle(follower.curr.x, follower.curr.y, 50);
  
  noFill();
  strokeWeight(2);
  stroke(50, 200, 20);
  circle(follower.target.x, follower.target.y, 20 - (frameCount % 50) / 3);

  strokeWeight(1);
  stroke(255, (9 - (frameCount % 10)) * 5);
  line(follower.curr.x, follower.curr.y, 
    follower.target.x, follower.target.y);
}

void mousePressed() {
  follower.setTarget(mouseX, mouseY);
}
