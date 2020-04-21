#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

varying vec3 pos;

void main() {
  float n = pos.x + pos.y + pos.z;
  n = pow(n, 1.3);
  gl_FragColor = vec4(
      sin(n), 
      sin(n*0.99), 
      sin(n*0.98), 
      1.);
}
