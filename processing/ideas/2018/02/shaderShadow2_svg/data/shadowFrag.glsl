#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

uniform sampler2D texture;
uniform bool enabled;
uniform vec3 c0, c1, c2, c3;

uniform vec2 texOffset;
varying vec4 vertTexCoord;

/*
Naive drop shadow shader.
It scans from the current fragment in one direction
until it finds a fragment with lower luminosity.
Based on the distance of the found fragment, it
darkens the current fragment.

Next: don't break the loop, instead scan a number
of pixels and add them up for darkness. Currently it
looks rough and glitchy.

But: a better approach that would be more correct is
to have each graphical item have it's own shadow,
so when an item is drawn to the screen, it includes
it's own shadow. That's the only way to have many
items layered on top of each other. Or is it not?

Maybe a depth image would also work, with up to 256
levels. Draw each item twice: one normal, once with
blendMode(DARKEN); Then use a shader on the depth
map to calculate the shadows, and finally apply them
on to the original image.
 */

// cosine based palette, 4 vec3 params
vec3 palette( in float t, in vec3 a, in vec3 b, in vec3 c, in vec3 d ) {
  return a + b*cos( 6.28318*(c*t+d) );
}

void main() {

  float a = texture2D(texture, vertTexCoord.st).r;
  vec3 base;

  if(a < 0.001) {
    base = vec3(1.0);
  } else {
    base = palette(a, c0, c1, c2, c3); 
  }

  if(enabled) {
    vec2 off = texOffset * vec2(-1.0, 1.0);
    float lum = 10.0;
    for (float i = 0.0; i <= 18.0; i++) {
      float b = texture2D(texture, vertTexCoord.st + (i+1.0) * off).r; 
      if(a < b) {
        float d = 1.0 - i/18.0; // 1=near.. 0=far
        lum = pow(lum, 1.0-0.015*d);
      }
    }
    gl_FragColor = vec4(base * lum * 0.1, 1.0);
  } else {
    gl_FragColor = vec4(base, 1.0);    
  }
}
