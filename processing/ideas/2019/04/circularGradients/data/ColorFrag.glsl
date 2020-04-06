#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform vec2 center;
uniform vec3 u_color;
varying vec2 pos;

void main() {
  float d = length(pos - center) * 0.01;
  float l = 0.2 * sin(d);
  gl_FragColor = vec4(u_color + l, 1.0);
}
