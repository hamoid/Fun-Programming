class Follower2D {
  public PVector target = new PVector();
  private PVector speed = new PVector();
  public PVector curr = new PVector();

  private float decelerateDistance = 50;
  private float lerpSpeed = 0.01f;

  public void setCurrent(float x, float y) {
    curr.set(x, y);
  }
  
  public void setTarget(float x, float y) {
    target.set(x, y);
  }
  
  public void setLerpSpeed(float speed) {
    lerpSpeed = speed;
  }
  
  public void setDecelerateDistance(float dist) {
    decelerateDistance = dist;
  }

  public void update() {
    PVector diff = PVector.sub(target, curr);
    float dist = diff.mag();
    diff.normalize();
    if (dist < decelerateDistance) {
      diff.mult(dist / decelerateDistance);
    }
    speed.lerp(diff, lerpSpeed);
    curr.add(speed);
  }
}
