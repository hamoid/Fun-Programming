uniform mat4 transform;
uniform mat4 modelview;
uniform mat3 normalMatrix;

attribute vec4 vertex;
attribute vec3 normal;

uniform sampler2D fft;

varying vec3 norm;

void main() {
  norm = normalize(normalMatrix * normal); // Vertex in eye coordinates
  
  // Here we use the normal to decide which point in the fft texture
  // to sample from. You don't need to use norm, you could use something
  // else like the vertex position.
  vec2 posInImage = vec2(0.5 + 0.5 * norm.x, 0.0);
  // Look at one pixel in the fft texture
  vec4 c = texture2D(fft, posInImage);
  
  gl_Position = transform * vertex;
  // Use the value obtained to deform the mesh
  gl_Position.y += c.r * 250.0;
}
