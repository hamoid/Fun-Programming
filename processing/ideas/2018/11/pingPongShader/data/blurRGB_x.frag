#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform sampler2D texture;
uniform vec2 texOffset;
uniform vec4 blur;
varying vec4 vertColor;
varying vec4 vertTexCoord;

void main() {
    vec3 color = 2.0 * texture2D(texture, vertTexCoord.st).rgb;

    vec3 offsets = texOffset.x * blur.rgb;

    vec2 off = vec2(offsets.r, 0.0);
    color.r += texture2D(texture, vertTexCoord.st + off).r;
    color.r += texture2D(texture, vertTexCoord.st - off).r;
    
    off.x = offsets.g;
    color.g += texture2D(texture, vertTexCoord.st + off).g;
    color.g += texture2D(texture, vertTexCoord.st - off).g;
    
    off.x = offsets.b;
    color.b += texture2D(texture, vertTexCoord.st + off).b;
    color.b += texture2D(texture, vertTexCoord.st - off).b;
    
    gl_FragColor = vec4(blur.a * color / 4.0, 1.0);
}
