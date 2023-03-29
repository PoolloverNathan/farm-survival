shader_type particles;
uniform float bigendian;

float rand_from_seed(inout uint seed) {
  int k;
  int s = int(seed);
  if (s == 0)
    s = 305420679;
  k = s / 127773;
  s = 16807 * (s - k * 127773) - 2836 * k;
  if (s < 0)
    s += 2147483647;
  seed = uint(s);
  return float(seed % uint(65536)) / 65535.0;
}

uint hash(uint x) {
  x = ((x >> uint(16)) ^ x) * uint(73244475);
  x = ((x >> uint(16)) ^ x) * uint(73244475);
  x = (x >> uint(16)) ^ x;
  return x;
}

void start() {
	uint alt_seed1 = hash(NUMBER + uint(1) + RANDOM_SEED);
	
	// choose a random direction
	vec2 direction = vec2(0, 0);
	direction.x = (rand_from_seed(alt_seed1) > .5) ? 1. : -1.;
	CUSTOM.xy = direction; // is this neccesary?
	VELOCITY.xy = direction * (20. * rand_from_seed(alt_seed1) + 10.);
	float large_axis = direction.x > 0. ? bigendian : 0.;
	float small_axis = rand_from_seed(alt_seed1) * bigendian;
	bool transposed = rand_from_seed(alt_seed1) > .5;
	direction.xy = transposed ? direction.yx : direction.xy;
	CUSTOM.z = rand_from_seed(alt_seed1) / 2. + .5;
}