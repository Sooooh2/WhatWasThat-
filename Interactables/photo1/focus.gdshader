shader_type spatial;
render_mode blend_mix,depth_draw_opaque;


uniform float alphaV : hint_range(0.0,1.0) = 0.5;
//uniform float str = 0.1;
//uniform float speed = 2.0;
uniform float border = 2.0;
uniform float str = 0.05;
void vertex() {
	//VERTEX += NORMAL * sin(TIME * speed * VERTEX.x * 5.0) * str;
    float edge = abs(UV.x - 0.5) * 2.0;
    edge = max(edge, abs(UV.y - 0.5) * 2.0);
	
    VERTEX += NORMAL * edge * sin(TIME * 8.0 + VERTEX.x * 3.0) * str;
}

void fragment() {
	//ALBEDO = vec3(1.0,1.0,1.0);
	ALPHA = alphaV;
}
