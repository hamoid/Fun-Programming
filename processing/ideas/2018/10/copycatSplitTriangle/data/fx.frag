#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

varying vec4 vertColor;

void main() {

  gl_FragColor = vec4(
      0.5 + 0.5 * sin(gl_FragCoord.x * .003), 
      0.5 + 0.5 * sin(gl_FragCoord.y * .006), 
      0.5 + 0.5 * sin(gl_FragCoord.x * .009), 
      1.0);
}
