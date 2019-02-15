//# define PROCESSING_TEXTURE_SHADER

uniform sampler2D texture;
uniform vec2 texOffset;
uniform float n;

varying vec4 vertColor;
varying vec4 vertTexCoord;

void main(void) {
  vec3 curr = texture2D(texture, vertTexCoord.st).rgb;
  float d = 1.0 / (curr.b * 900.0 + curr.r * 250.0 + curr.g * 90.0);
  float a = n + curr.r * 8.0 - curr.g * 0.5 + curr.b * 0.2;
  vec2 src = vertTexCoord.st + d * vec2(sin(a), cos(a));
  vec3 col = texture2D(texture, src).rgb;
  col.g = col.g * 0.997;
  col.b = col.b * 0.994;
  gl_FragColor = vec4(mix(curr, col, 0.2), 1.0);
}
