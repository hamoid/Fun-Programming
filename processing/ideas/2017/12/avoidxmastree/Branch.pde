class Branch {
  private CurveCreator curve;
  private int pointCount;
  private final int lineRes = 2;
  private Mesh3D m;
  private int farbe;
  private Particle particle;
  
  private float ballTargetSize;
  private float ballSize = 0;
  private Vec2D ballPos;

  Branch() {
    particle = new Particle();
    reset();
  }
  void update() {
    if (!particle.done) {
      PVector pos = particle.move();
      add(pos.x, pos.y);
      calcMesh();
      if (particle.done && pointCount < 40) {
        reset();
      }
    } else if (ballSize < ballTargetSize) {
      ballSize++;
    }
  }
  void reset() {
    pointCount = 0;
    ballTargetSize = random(10, 20);
    curve = new CurveCreator(2);
    m = new TriangleMesh();
    farbe = color(40, 120, 40); //color(random(40), random(100, 150), random(40));
    particle.findSpot();
  }
  void add(float x, float y) {
    curve.addControlPoint(new Vec3D(x, y, 0));
    pointCount++;
  }
  void calcMesh() {
    if (pointCount < 3) {
      return;
    }

    m.clear();

    Vec3D p0 = new Vec3D();
    Vec3D p1 = new Vec3D();
    Vec3D p0b = new Vec3D();
    Vec3D p1b = new Vec3D();

    Vec3D a = new Vec3D();
    Vec3D b = new Vec3D();
    NurbsCurve ncurve = curve.getCurve();
    Polygon2D p = ncurve.toPolygon2D(pointCount * lineRes);
    int lineSegments = p.vertices.size();
    for (int i=0; i<lineSegments-1; i++) {
      a.setXY(p.vertices.get(i));
      b.setXY(p.vertices.get(i+1));
      float angle = atan2(b.y - a.y, b.x - a.x);

      float linePc = (float)i/(lineSegments-1);
      float maxw = (8 + 8 * (float)SimplexNoise.noise(a.x * 0.003, a.y * 0.003));
      //float maxw = 10 + lineSegments * 0.01;
      //float maxw = 5;
      float wi = 1 + maxw * cos(-HALF_PI + linePc * PI);

      p0.set(wi/2, 0, angle + HALF_PI);
      p1.set(wi/2, 0, angle - HALF_PI);
      p0.toCartesian();
      p1.toCartesian();

      p0.addSelf(a);
      p1.addSelf(a);

      if (i > 3) {
        m.addFace(p0b, p0, p1);
        m.addFace(p0b, p1, p1b);
      }
      p0b.set(p0);
      p1b.set(p1);
    }
    ballPos = p.vertices.get(0);
  }
  void draw() {
    noStroke();
    fill(farbe);
    toxic.mesh(m, true);
    if (ballSize > 0) {
      fill(255, 0, 0);
      ellipse(ballPos.x, ballPos.y, ballSize, ballSize);
    }
  }
}