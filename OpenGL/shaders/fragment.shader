#version 330 core
out vec4 FragColor;

in vec3 color;
in vec2 uv;
in mat3 tbn;
in vec3 worldPosition;


uniform sampler2D mainTex;
uniform sampler2D normalTex;

uniform vec3 lightPosition;
uniform vec3 cameraPosition;

uniform float shininess = 64;

uniform vec3 specColor = vec3(1.0); // default 100% white
uniform vec3 lowSpecColor = vec3(0.1); // default 10% white
uniform vec3 gold  = vec3(1.0, 0.9, 0.7); //more shiny gold look
uniform vec3 dull = vec3(0.15, 0.05, 0.05); //less shiny dull lighting look

void main()
{
	//#normal map
	vec3 normal = texture(normalTex, uv).rgb;
	normal = normalize(normal * 2.0 - 1.0);
	//#Scale down normal
	normal.rg = normal.rg * 0.75;
	normal = normalize(normal);
	//#transform with TBN
	normal = tbn * normal;

	vec3 lightDir = normalize(worldPosition-lightPosition);

	//#specular data
	vec3 viewDir = normalize(worldPosition - cameraPosition);
	vec3 reflDir = normalize(reflect(lightDir, normal));

	//#lighting
	float lightValue = max(-dot(normal, lightDir), 0.0);
	float specular = pow(max(-dot(reflDir, viewDir), 0.0), shininess);

	//#seperate RGB and RGBA calculations
	vec4 texColor = vec4(color, 1.0) * texture(mainTex, uv);

	vec3 combinedColor = texColor.rgb * lightValue + specular * dull;
	combinedColor = clamp(combinedColor + 0.1, 0.0, 1.0);

	FragColor = vec4(combinedColor, texColor);

}