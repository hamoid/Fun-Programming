#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

varying vec4 vertColor;

void main() {
  // test based on pixel location
  // darken or brighten based on sine of coords
  //gl_FragColor = vec4(vertColor.rgb*(1.0+0.1*sin(
  //  gl_FragCoord.x * 0.04 + 
  //  gl_FragCoord.y * 0.04
  //)), 1.0);

  // vertColor comes from vertex shader,
  // and this shader interpolates those vertColor
  gl_FragColor = vertColor;
}
