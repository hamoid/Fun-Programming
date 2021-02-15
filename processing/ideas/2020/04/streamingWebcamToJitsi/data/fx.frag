#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

uniform sampler2D texture;
uniform vec2 texOffset;
uniform float time;
varying vec4 vertColor;
varying vec4 vertTexCoord;

void main() {
  vec2 p = vertTexCoord.st;
  vec3 c = texture2D(texture, p).rgb;
  if(abs(c.r - c.g) < 0.03 && c.r > 0.5) {
    c = vec3(0.0, 0.7, 0.0);
    c.r = step(0.5, sin(time + length(p * 20.0)));
    c.b = step(0.5, fract(time + p.x * 10.0));
  }  
  gl_FragColor = vec4(c, 1.0);
}
