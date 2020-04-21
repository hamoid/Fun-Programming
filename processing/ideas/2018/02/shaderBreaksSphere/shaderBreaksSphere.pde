import peasy.PeasyCam;

PeasyCam cam;
ShaderReloader fx;

void setup() {
  size(600, 600, P3D);
  cam = new PeasyCam(this, 400);
  fx = new ShaderReloader(this, "frag1.glsl", "vert1.glsl");
  hint(DISABLE_OPTIMIZED_STROKE);
}

void draw() {
  background(0);

  fx.apply();

  noStroke();
  sphere(300);
  
  fx.debug();
}
