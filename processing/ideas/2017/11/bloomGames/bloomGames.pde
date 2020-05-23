import com.thomasdiewald.pixelflow.java.DwPixelFlow;
import com.thomasdiewald.pixelflow.java.imageprocessing.filter.DwFilter;

DwPixelFlow context;
DwFilter filter;

PGraphics2D R;
PGraphics2D pg_luminance;
PGraphics2D pg_bloom;

int w = 700, h = 700;

public void settings() {
  size(w, h, P2D);
  smooth(0);
}

public void setup() {
  context = new DwPixelFlow(this);
  filter = new DwFilter(context);

  R = (PGraphics2D) createGraphics(w, h, P2D);
  pg_luminance = (PGraphics2D) createGraphics(w, h, P2D);
  pg_bloom = (PGraphics2D) createGraphics(w, h, P2D);

  background(0);
}


public void draw() {
  R.beginDraw();
  R.blendMode(SUBTRACT);
  R.fill(map(mouseX, 0, width, 0, 255));
  R.rect(0, 0, R.width, R.height);
  R.blendMode(BLEND);
  R.translate(R.width/2, R.height/2);
  R.colorMode(HSB);
  for(int i=0; i<10; i++) {
    R.fill(i*25, 150, 100, 50 + 10 * sin(frameCount*0.09+i*0.11));
    R.rotate(0.005*(i+frameCount));
    R.rect(50+50*i*sin((i+i*frameCount*0.1)*0.003), 0, 1000+i*10, 10+i*10);
    R.ellipse(50+50*i*sin((i+i*frameCount*0.1)*0.003), 0, 100+i*10, 100+i*10);
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
  filter.bloom.param.radius = 0.5; // 0..1.0
  filter.bloom.apply(pg_luminance, pg_bloom, R);

  // display result
  blendMode(REPLACE);
  background(0);
  image(R, 0, 0);
}

void keyPressed() {
    if(key =='s') { save("thumb.jpg"); println("saved!"); }
}
