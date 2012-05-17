/*
  Attempt to create a keyframe animation system with
  smooth transitions.
  
  This version correctly passes keyframe locations at
  the right time, but there is an abrupt speed 
  change when passing keyframes if the duration of 
  the last and the next segment greatly differs.

  I tried calculating the segment density (hack, I know)
  and then adjusting the control point distances to
  try to counteract the sudden speed changes. Not good :)
  
  Next attempt should use Catmull-Rom spline curves.

  Ideas: create Timeline class that contains Segment objects,
  current segment, current Timeline-time, Segment-time.  
*/

int L = 15; // amount of keyframes
Keyframe[] frame = new Keyframe[L];
int F = 0;

void setup() {
  size(400, 400);
  background(255);
  smooth();
  
  // Create random keyframes
  for(int i=0; i<L; i++) {
    frame[i] = new Keyframe(
      random(50, width-50), 
      random(50, height-50), 
      i == 0 ? 0 : frame[i-1].frame + int(random(50, 200))
    );
  }    
 
}
void draw() {
  background(255);

  //frame[1].pos.x = mouseX;
  //frame[1].pos.y = mouseY;

  // Draw keyframe locations
  for(int i=0; i<L; i++) {
    noStroke();
    fill(255,0,0, 100);
    ellipse(frame[i].pos.x, frame[i].pos.y, 8, 8);
    noFill();
    
    stroke(0, 50);
    if(i>0) {
      // join keyframes with straight lines
      line(frame[i-1].pos.x, frame[i-1].pos.y, frame[i].pos.x, frame[i].pos.y);
    }
  }  

  PVector now = getPos(F);
  stroke(0, 120);
  ellipse(now.x, now.y, 10, 10);
  
  if(true || mousePressed) {
    F++;
  }
}

// Could be really optimized. All calculations
// are done each time this function is called,
// but many could be cached because certain values only
// change when after we jump to the next segment.
PVector getPos(int t) {
  // If time is 0 or less, return the initial position
  if(t < 1) {
    return frame[0].pos;
  }  
  // If time is past the last keyframe, return last position
  if(t >= frame[L-1].frame) {
    return frame[L-1].pos;
  }
  int segment = getCurrentSegment(t);
  float time = getTimeInCurrentSegment(t, segment); 

  // Lineal tweening start
  // float newx = lerp(frame[segment].pos.x, frame[segment+1].pos.x, time);
  // float newy = lerp(frame[segment].pos.y, frame[segment+1].pos.y, time);
  // Lineal tweening end

  // Bezier tweening start
  // Calculate the first control point for the bezier curve 
  PVector control0, control1;
  float angFrom, angTo, ang, dx=0, dy=0, segmentLength;



    
  // Calculate the first control point for the bezier curve 
  if(segment > 0) {
    angFrom = atan2(frame[segment+1].pos.y - frame[segment].pos.y, frame[segment+1].pos.x - frame[segment].pos.x);
    angTo = atan2(frame[segment].pos.y - frame[segment-1].pos.y, frame[segment].pos.x - frame[segment-1].pos.x);

    stroke(0, 0, 255);
    strokeWeight(1);
    ellipse(frame[segment-1].pos.x, frame[segment-1].pos.y, 8, 8); 
    ellipse(frame[segment].pos.x, frame[segment].pos.y, 8, 8); 
    ellipse(frame[segment+1].pos.x, frame[segment+1].pos.y, 8, 8); 
    
    //float curr_density = (frame[segment+1].frame - frame[segment].frame) / PVector.dist(frame[segment].pos, frame[segment+1].pos);
    //float prev_density = (frame[segment].frame - frame[segment - 1].frame) / PVector.dist(frame[segment].pos, frame[segment-1].pos);
    float denscoef = 1; //prev_density / curr_density; // small number means speed increase, large number means slower
    
    segmentLength = denscoef * PVector.dist(frame[segment].pos, frame[segment+1].pos) / 2;

    ang = getTangent(angFrom, angTo);
    dx = segmentLength * cos(ang);
    dy = segmentLength * sin(ang);    
  } 
  control0 = new PVector(frame[segment].pos.x + dx, frame[segment].pos.y + dy);




  // Calculate the second control point for the bezier curve 
  dx = 0;
  dy = 0;
  if(segment < L-2) {
    angFrom = atan2(frame[segment].pos.y - frame[segment+1].pos.y, frame[segment].pos.x - frame[segment+1].pos.x);
    angTo = atan2(frame[segment+1].pos.y - frame[segment+2].pos.y, frame[segment+1].pos.x - frame[segment+2].pos.x);

    stroke(0, 0, 255);
    strokeWeight(1);
    ellipse(frame[segment].pos.x, frame[segment].pos.y, 12, 12); 
    ellipse(frame[segment+1].pos.x, frame[segment+1].pos.y, 12, 12); 
    ellipse(frame[segment+2].pos.x, frame[segment+2].pos.y, 12, 12); 

    //float curr_density = (frame[segment+2].frame - frame[segment+1].frame) / PVector.dist(frame[segment+1].pos, frame[segment+2].pos);
    //float prev_density = (frame[segment+1].frame - frame[segment].frame) / PVector.dist(frame[segment+1].pos, frame[segment].pos);
    float denscoef = 1; //prev_density / curr_density; // small number means speed increase, large number means slower

    segmentLength = denscoef * PVector.dist(frame[segment].pos, frame[segment+1].pos) / 2;

    ang = getTangent(angFrom, angTo);
    dx = segmentLength * cos(ang);
    dy = segmentLength * sin(ang);
  } 
  control1 = new PVector(frame[segment+1].pos.x + dx, frame[segment+1].pos.y + dy);
 
 
 
  // Calculate the position of the current point using bezier
  float newx = bezierPoint(frame[segment].pos.x, control0.x, control1.x, frame[segment+1].pos.x, time);
  float newy = bezierPoint(frame[segment].pos.y, control0.y, control1.y, frame[segment+1].pos.y, time);
  // bezier end

  strokeWeight(1);
  stroke(#FF0000);
  line(frame[segment].pos.x, frame[segment].pos.y, control0.x, control0.y);
  stroke(#00FF00);
  line(control1.x, control1.y, frame[segment+1].pos.x, frame[segment+1].pos.y);
  
  return new PVector(newx, newy);
}
float getTangent(float fromAngle, float toAngle) {
  if(fromAngle < 0) {
    fromAngle += TWO_PI;
  }
  if(toAngle < 0) {
    toAngle += TWO_PI;
  }
  float ang = fromAngle + (toAngle - fromAngle) / 2;
  if(abs(fromAngle - toAngle) > PI) {
    ang -= PI;
  } 

  return ang;
}
float getTimeInCurrentSegment(int t, int segment) {
  float segmentLength = frame[segment+1].frame - frame[segment].frame;
  float relativeIndex = t - frame[segment].frame;
  return relativeIndex / segmentLength;
}
int getCurrentSegment(int t) {
  int segment;
  for(segment=0; segment<L; segment++) {
    if(frame[segment].frame > t) {
      return segment - 1;
    }
  }
  return 0;
}

class Keyframe {
  PVector pos;
  int frame;
  
  Keyframe(float x, float y, int frame) {
    this.pos = new PVector(x, y);
    this.frame = frame;
  }
}
