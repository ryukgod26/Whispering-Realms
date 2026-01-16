shader_type canvas_item;

uniform vec4 line_color : source_color = vec4(0.0, 0.8, 1.0, 1.0);
uniform float speed = 5.0;
uniform float thickness = 0.05;
uniform float frequency = 10.0;
uniform float amplitude = 0.1;

float hash(vec2 p) {
	return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453123);
}

float noise(vec2 p) {
	vec2 i = floor(p);
	vec2 f = fract(p);
	vec2 u = f * f * (3.0 - 2.0 * f);
	return mix(mix(hash(i + vec2(0.0, 0.0)), hash(i + vec2(1.0, 0.0)), u.x),
		       mix(hash(i + vec2(0.0, 1.0)), hash(i + vec2(1.0, 1.0)), u.x), u.y);
}

void fragment() {
	vec2 uv = UV;

	// Animate the noise over time
	float t = TIME * speed;
	float noise_val = noise(vec2(uv.x * frequency, t));

	// Calculate the center line with displacement
	float dist = abs(uv.y - 0.5 + (noise_val - 0.5) * amplitude);

	// Create the glowing line effect
	float alpha = smoothstep(thickness, 0.0, dist);

	// Random flicker effect
	float flicker = clamp(noise(vec2(t * 2.0, t)), 0.5, 1.0);

	COLOR = vec4(line_color.rgb, alpha * flicker * line_color.a);
}