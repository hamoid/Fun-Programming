/*
  4. Spherical
 */
void viz4() {
  hires.beginDraw();
  hires.clear();

  int W = hires.width;
  int H = hires.height;
  float K = hires.width / (float)width; 

  hires.ortho();
  drawGradient(hires, #16282E, #000000);
  dither(hires);
  drawStars(hires, K);

  hires.noLights();
  hires.ambientLight(0, 0, 40);
  //hires.lightFalloff(0.8/K, 0.0007/K, 0.0);
  hires.pointLight(0, 0, 160, -W*0.8, -H*0.9, H*0.3);
  hires.pointLight(20, 63, 250, W*0.8, H*0.9, H*0.2);

  hires.perspective(PI/3.0, W/H, 1, 10000); 

  hires.camera(
  W*0.5, H*0.36, H*0.28, 
  W*0.5, H*0.25, 0, 
  0, 1, 0);

  hires.pushMatrix();
  hires.translate(W/2, H/4);
  hires.rotateX(1);
  
  float sk = K * hires.width / 2.5;
  
  float[] rot = cf.getRotation();
  
  for (int dy=0; dy<data.h; dy++) {
    float step = data.w / map(sin(data.py(dy) * PI), 0, 1, 1, data.w);
    for (int dx=0; dx<data.w; dx+=step) {
      float val = data.D[dx][dy];
      hires.pushMatrix();

      hires.rotateX(rot[0] * TWO_PI);
      hires.rotateZ(rot[1] * TWO_PI);
      hires.rotateX(PI + data.px(dx) * TWO_PI);
      hires.rotateZ(data.py(dy) * TWO_PI); // Should be PI
      hires.translate(hires.width / 11 + hires.width / 15 * val , 0, 0);
      hires.rotateX(random(TWO_PI));

      hires.noStroke();
      hires.fill(
        (-60+val * 256 + random(6)) % 256, 
        sin(val * 10) * 128 + 128, 
        sin(val * 7) * 100 + 150 + random(10));
        
      hires.box(hires.width/155.0, hires.width/500.0, hires.width/500.0);

      if (val > data.topThreshold) {
        hires.stroke(0, 255, 255, 40);
        hires.strokeWeight(hires.width/875.0);
        hires.line(0, 0, 0, random(hires.width/10), 0, 0);
      }
      
      hires.popMatrix();
    }
  }

  hires.popMatrix();
  hires.endDraw();

  background(0);
  clear();
  copy(hires, 0, 0, hires.width, hires.height, 0, 0, width, height);
}

