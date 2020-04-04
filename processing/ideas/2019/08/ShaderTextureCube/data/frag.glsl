#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform float t;

void main() {
  vec2 p = (gl_FragCoord.xy - 100.0) * 0.02;
  float r = 0.5 + 0.4 * sin(p.x * p.y * 1.1 + t);
  float g = 0.5 + 0.4 * sin(p.x * p.y * 1.2 + t);
  float b = 0.5 + 0.4 * sin(p.x * p.y * 1.3 + t);
  gl_FragColor = vec4(r, g, b, 1.0);
}
