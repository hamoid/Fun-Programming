uniform mat4 transformMatrix;
attribute vec4 position;     
uniform float time;
varying vec3 pos;

void main() {
  float a = position.x*.033 + position.y*.033 + position.z * 0.02 + time*.3;
  float r = position.z*.5*sin(time*.007);
  float k = .055 + .045 * sin(time * .03);
  gl_Position = vec4(
    r*sin(a)*.5,
    r*cos(a),
    r*sin( position.x*k + position.y*k + time*.1),
    1.0
  );

  pos = vec3(position) * 0.1;
  //pos = gl_Position.xyz / 2. + 0.5;
}
