import toxi.geom.mesh2d.*;
import toxi.geom.*;
import java.util.*;

Rect screen;

void setup() {
  size(875, 875);
  background(#C0B040);
  screen = new Rect(-width*0.4, -height*0.4, width*0.6, height*0.6);
}
void draw() {
  fill(#C0B040, 30);
  noStroke();
  float tx = 5*frameCount % width;
  rect(tx, 0, 5, height);

  Voronoi v = new Voronoi(); 
  for (int i=0; i<20; i++) {
    float x = map(noise(frameCount * 0.002, i), 0, 1, screen.x, screen.x + screen.width);
    float y = map(noise(i, frameCount * 0.0021), 0, 1, screen.y, screen.y + screen.height);
    v.addPoint(new Vec2D(x, y));
  }  

  translate(width/2, height/2);
  rotate(TAU * 2 * noise(frameCount * 0.001));

  List<Triangle2D> tri = v.getTriangles();  
  for (int i=0; i<tri.size(); i++) {
    Triangle2D t = tri.get(i);
    if (screen.containsPoint(t.a) && screen.containsPoint(t.b) && screen.containsPoint(t.c)) { 
      stroke(#405005, 30);
      strokeWeight(1);
      line(t.a.x, t.a.y, t.b.x, t.b.y);
      line(t.b.x, t.b.y, t.c.x, t.c.y);
      line(t.c.x, t.c.y, t.a.x, t.a.y);
      stroke(#FF0000, 128);
      strokeWeight(2);
      point(t.a.x, t.a.y);
      point(t.b.x, t.b.y);
      point(t.c.x, t.c.y);
    }
  }
}
void keyPressed() {
  if (key == 's') {
    saveFrame("####.png");
  }
}

