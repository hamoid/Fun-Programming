size(400, 400);
translate(200, 200);
noStroke();
smooth();
fill(255, 0, 0);
background(255);

int[] x = { 0, 50, 0, -50 };
int[] y = { 20, -57, -60, -57 };
int SR = 30;

beginShape();
vertex(x[0], y[0]);
bezierVertex(x[0]+20, y[0]-30, x[1], y[1]+SR, x[1], y[1]);
bezierVertex(x[1], y[1]-SR, 10, -100, x[2], y[2]);
bezierVertex(-10, -100, x[3], y[3]-SR, x[3], y[3]);
bezierVertex(x[3], y[3]+SR, x[0]-20, y[0]-30, x[0], y[0]);
endShape();
