#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform sampler2D texture;

uniform vec2 texOffset;

varying vec4 vertColor;
varying vec4 vertTexCoord;

void main() {

    vec2 p = -1.0 + 2.0 * vertTexCoord.st;
    vec2 uv;
   
    float a = atan(p.y, p.x);
    float r = length(p);
    
    uv.x = 0.5 + 0.5 * r * cos(a*5.0);
    uv.y = 0.5 + 0.5 * r * sin(a*5.0);

    vec3 col = texture2D(texture, uv).xyz;
    gl_FragColor = vec4(col, 1.0); 
}
