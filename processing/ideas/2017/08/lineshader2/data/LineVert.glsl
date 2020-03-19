#define PROCESSING_LINE_SHADER

uniform mat4 modelviewMatrix;
uniform mat4 projectionMatrix;

uniform vec4 viewport;
uniform int perspective;
uniform vec3 scale;

attribute vec4 position;
attribute vec4 color;
attribute vec4 direction;

varying vec4 vertColor;

vec3 clipToWindow(vec4 clip, vec4 viewport) {
  vec3 post_div = clip.xyz / clip.w;
  vec2 xypos = (post_div.xy + vec2(1.0, 1.0)) * 0.5 * viewport.zw;
  return vec3(xypos, post_div.z * 0.5 + 0.5);
}
  
vec4 windowToClipVector(vec2 window, vec4 viewport, float clip_w) {
  vec2 xypos = (window / viewport.zw) * 2.0;
  return vec4(xypos, 0.0, 0.0) * clip_w;
}  
  
void main() {
  vec4 posp = modelviewMatrix * position;
    
  // Moving vertices slightly toward the camera
  // to avoid depth-fighting with the fill triangles.
  // Discussed here:
  // http://www.opengl.org/discussion_boards/ubbthreads.php?ubb=showflat&Number=252848  
  posp.xyz = posp.xyz * scale;
  vec4 clipp = projectionMatrix * posp;
  float thickness = direction.w *
    (0.5 + 0.45 * sin(posp.y * 0.02) *
                  cos(posp.x * 0.02));
  
  if (thickness != 0.0) {  
    vec4 posq = posp + modelviewMatrix * vec4(direction.xyz, 0);
    posq.xyz = posq.xyz * scale;  
    vec4 clipq = projectionMatrix * posq; 
  
    vec3 window_p = clipToWindow(clipp, viewport); 
    vec3 window_q = clipToWindow(clipq, viewport); 
    vec3 tangent = window_q - window_p;
    
    vec2 perp = normalize(vec2(-tangent.y, tangent.x));
    vec2 offset = perp * thickness;

    if (0 < perspective) {
      // Perspective correction (lines will look thiner as they move away 
      // from the view position).  
      gl_Position.xy = clipp.xy + offset.xy;
      gl_Position.zw = clipp.zw;
    } else {
      // No perspective correction.	
      vec4 offsetp = windowToClipVector(offset, viewport, clipp.w);
      gl_Position = clipp + offsetp;
    }    
  } else {
    gl_Position = clipp;
  }
  
  vertColor = vec4(
      color.r * (1.0 + 0.5*sin(posp.z*0.01)), 
      color.g * (1.0 + 0.5*sin(posp.z*0.011)), 
      color.b * (1.0 + 0.5*sin(posp.z*0.012)), 
      1.0);
}
