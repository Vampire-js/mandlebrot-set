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
return complexMul(z,z) + c ;
}

void main() {
    float zoom = 2.2;  
vec2 center = vec2(-.0, .0);

vec2 uv = gl_FragCoord.xy / u_resolution;
vec2 aspect = vec2(u_resolution.x / u_resolution.y, 1.0);

vec2 c = (uv - 0.5) * zoom * aspect + center;



    vec2 z0 = vec2(0,0);

    for(int i=0; i<100; i++){
        vec2 new = mandlebrot(z0, c);
        z0 = new;
    }

 
    vec3 color = (length(z0) > 2.) ? vec3(1,1,1) : vec3(0.);
    gl_FragColor = vec4(color, 1.);
}