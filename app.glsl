precision mediump float;

uniform float u_time;
uniform vec2 u_resolution;

vec2 complexMul(vec2 a, vec2 b) {
    return vec2(
        a.x * b.x - a.y * b.y,
        a.x * b.y + a.y * b.x
    );
}

vec2 mandlebrot(vec2 z , vec2 c){
    return complexMul(z,z) + c;
}

void main() {
    float zoom = 1.4;  
    vec2 center = vec2(-1.0, 0.0);

    vec2 uv = gl_FragCoord.xy / u_resolution;
    vec2 aspect = vec2(u_resolution.x / u_resolution.y, 1.0);
    vec2 c = (uv - 0.5) * zoom * aspect + center;

    vec2 z = vec2(0.0);
    const int max_iter = 100;
    float iterCount = float(max_iter);

    for(int i = 0; i < max_iter; i++) {
        z = mandlebrot(z, c);
        if(length(z) > 2.0) {
            iterCount = float(i);
            break;
        }
    }
    
    float t = iterCount / float(max_iter);
    if (iterCount < float(max_iter)) {
        float col = cos(u_time)*(iterCount - length(z));
        t = col / float(max_iter);
    } else {
        t = 0.0;
    }

    vec3 color = vec3(0.5 + 0.5 * cos(6.2831 * (vec3(0.0, 0.33, 0.66) + t)));
    gl_FragColor = vec4(color, 1.0);
}
