#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

// This is the fft texture image created in Processing
uniform sampler2D fft;

uniform vec2 texOffset;
varying vec4 vertColor;
varying vec4 vertTexCoord;

void main() {
  // Map the screen position to a position in the fft texture image
  vec2 posInImage = vec2(vertTexCoord.x, 0.0);
  
  // A. Show as a "graph"
  //vec4 c = 1.0 - texture2D(fft, posInImage);
  //float diff = abs(vertTexCoord.y - c.r);
  //gl_FragColor = diff > 0.01 ? vec4(0.0, 0.0, 0.0, 1.0) : vec4(1.0);

  // B. Show as color
  vec4 c = texture2D(fft, posInImage);
  gl_FragColor = c;

}


