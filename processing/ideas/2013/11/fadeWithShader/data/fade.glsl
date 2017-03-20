#define PROCESSING_TEXTURE_SHADER

uniform vec3 TargetColor;
uniform sampler2D texture;
varying vec4 vertColor;
varying vec4 vertTexCoord;

void main(void) {
    vec3 curr = texture2D(texture, vertTexCoord.st).rgb;
    float r = curr.r + 0.002 * (curr.r<TargetColor.r ? 1.0 : -1.0);
    float g = curr.g + 0.003 * (curr.g<TargetColor.g ? 1.0 : -1.0);
    float b = curr.b + 0.005 * (curr.b<TargetColor.b ? 1.0 : -1.0);
    gl_FragColor = vec4(r, g, b, 1.0) * vertColor;
}
