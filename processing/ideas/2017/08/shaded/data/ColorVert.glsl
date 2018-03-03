uniform mat4 transformMatrix;
attribute vec4 position;
attribute vec4 color;
varying vec4 vertColor;

void main() {
  gl_Position = transformMatrix*position;
  
  // darken or brighten color based on sine
  // of distance to screen center
  //vertColor = vec4(color.rgb*(1.0+0.3*sin(length(position.xyz*0.05))), 1.0);

  // same as above, but different sine frequency
  // for R G and B (creating subtle hue gradients)
  vertColor = vec4(
      color.r*(1.0+0.3*sin(length(position.xyz*0.051))), 
      color.g*(1.0+0.3*sin(length(position.xyz*0.052))), 
      color.b*(1.0+0.3*sin(length(position.xyz*0.053))), 
      1.0);
}
