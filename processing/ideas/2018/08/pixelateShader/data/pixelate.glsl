#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform sampler2D texture;

uniform vec2 texOffset;
uniform vec2 res;

varying vec4 vertColor;
varying vec4 vertTexCoord;

void main() {
  vec2 uv = floor(vertTexCoord.st * res) / res;
  gl_FragColor = texture2D(texture, uv);
}
