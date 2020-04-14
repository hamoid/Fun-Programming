// Based on Processing's default line shader
// Use gl_VertexID to determine thickness based on 
// how far in the curve we are.

uniform mat4 modelviewMatrix;
uniform mat4 projectionMatrix;

uniform vec4 viewport;
uniform int perspective;
uniform vec3 scale;
uniform int numVertices;

attribute vec4 position;
attribute vec4 color;
attribute vec4 direction;

varying vec4 vertColor;

const float PI = 3.14159;
  
void main() {
  vec4 posp = modelviewMatrix * position;
  vec4 posq = modelviewMatrix * (position + vec4(direction.xyz, 0));

  // Moving vertices slightly toward the camera
  // to avoid depth-fighting with the fill triangles.
  // Discussed here:
  // http://www.opengl.org/discussion_boards/ubbthreads.php?ubb=showflat&Number=252848  
  posp.xyz = posp.xyz * scale;
  posq.xyz = posq.xyz * scale;

  vec4 p = projectionMatrix * posp;
  vec4 q = projectionMatrix * posq;

  vec2 tangent = (q.xy*p.w - p.xy*q.w) * viewport.zw;

  // don't normalize zero vector (line join triangles and lines perpendicular to the eye plane)
  tangent = length(tangent) == 0.0 ? vec2(0.0) : normalize(tangent);

  // flip tangent to normal (it's already normalized)
  vec2 normal = vec2(-tangent.y, tangent.x);

  // I'm not sure why the 5.0 is required. That seems to imply that for each
  // vertex() call we get 5 vertices in the shader. We should look into the
  // Processing source code to understand this.
  float percent = gl_VertexID / (numVertices * 5.);
  float thickness = 0.5 + 0.5 * cos(PI * 2 * percent - PI);
  vec2 offset = normal * thickness * direction.w;

  // Perspective ---
  // convert from world to clip by multiplying with projection scaling factor
  // to get the right thickness (see https://github.com/processing/processing/issues/5182)
  // invert Y, projections in Processing invert Y
  vec2 perspScale = (projectionMatrix * vec4(1., -1., 0., 0.)).xy;

  gl_Position.xy = p.xy + offset.xy * perspScale;
  gl_Position.zw = p.zw;

  vertColor = color;
  // brightness modulation
  vertColor.rgb *= 1.0 + 0.4 * sin(15.0 * percent);
}
