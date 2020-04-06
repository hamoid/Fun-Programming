uniform mat4 transformMatrix;

attribute vec4 position;
attribute vec4 color;

varying vec2 pos;
uniform float rotation;

mat2 rotation2d(float angle) {
  float s = sin(angle);
  float c = cos(angle);
  return mat2(c, -s, s, c);
}

void main() {
  pos = position.xy;

  float k = 1200.0 / 700.0;

  vec4 p = transformMatrix * position;
  p.x *= k;
  p.xy *= rotation2d(rotation * (1.0 - smoothstep(250., 500., length(p.xy - 0.5))));
  p.x /= k;
  gl_Position = p;
}
