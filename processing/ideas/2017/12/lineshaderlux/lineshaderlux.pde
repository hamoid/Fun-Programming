import com.thomasdiewald.pixelflow.java.DwPixelFlow;
import com.thomasdiewald.pixelflow.java.imageprocessing.filter.DwFilter;

DwPixelFlow context;
DwFilter filter;

PGraphics3D R;
PGraphics2D pg_luminance;
PGraphics2D pg_bloom;

int w = 700, h = 700;
float tk = 1;
float[] thet = new float[50];

public void settings() {
  size(w, h, P2D);
  smooth(0);
}

void setup() {
  context = new DwPixelFlow(this);
  filter = new DwFilter(context);

  R = (PGraphics3D) createGraphics(w, h, P3D);
  pg_luminance = (PGraphics2D) createGraphics(w, h, P2D);
  pg_bloom = (PGraphics2D) createGraphics(w, h, P2D);

  R.shader(loadShader("LineFrag.glsl", "LineVert.glsl"));
}

void draw() {
  R.beginDraw();
  R.background(#010204);
  R.noFill();
  R.strokeWeight(20);
  for (int i=0; i<50; i++) {
    if ((frameCount + i) % 41 < 15) {
      tk = lerp(tk, 2, 0.3);
    } else {
      tk = lerp(tk, 0, 0.3);
    }
    thet[i] += tk;
    R.stroke(80+i*2, 140-i*2, 15, 120);
    float x = (thet[i] + frameCount * noise(0, i)) % (width + 200) - 100;
    float y = noise(i, x * 0.001) * height;
    R.ellipse(x, y, 20+i*2, 20+i*2);
  }
  R.endDraw();

  // luminance pass
  filter.luminance_threshold.param.threshold = 0.0f; // when 0, all colors are used
  filter.luminance_threshold.param.exponent  = 5;
  filter.luminance_threshold.apply(R, pg_luminance);

  // bloom pass
  // if the original image is used as source, the previous luminance pass 
  // can just be skipped
  filter.bloom.param.mult   = 3;   // 0..10
  filter.bloom.param.radius = 0.8; // 0..1.0
  filter.bloom.apply(pg_luminance, pg_bloom, R);

  // display result
  blendMode(REPLACE);
  background(0);
  image(R, 0, 0);
}
