#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

varying vec4 vertColor;
varying vec4 backVertColor;
varying vec3 pos;

uniform int axis;

void main() {
  gl_FragColor = (gl_FrontFacing ? vertColor : backVertColor);
  gl_FragColor.rgb *= (1.0 + 0.1 * sin(pos[axis] * 0.53)); 
}
