#version 330 core
out vec4 FragColor;

in vec3 normal;  
in vec3 fragPos;

uniform vec3 lightPosition;

uniform vec3 objectColor = vec3(1.0,0,0); //red
uniform vec3 lightColor = vec3(0,0,1.0); //blue)
uniform vec3 ambient = vec3(0.1);

void main()
{
	vec3 norm = normalize(normal);
	vec3 lightDir = normalize(lightPosition - fragPos);

	float diff = max(dot(norm, lightDir), 0.0);
	vec3 diffuse = diff * lightColor;

	vec3 result = (ambient + diffuse) * objectColor;
	FragColor = vec4(result, 1.0);

}