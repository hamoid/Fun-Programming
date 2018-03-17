#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform sampler2D fft;

varying vec3 norm;

void main() {
  // Use the vertex normal to define the pixel color
  vec4 c = vec4(norm, 1.0);
  gl_FragColor = c;
}


