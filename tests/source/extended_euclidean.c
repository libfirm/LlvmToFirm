#include <stdio.h>

// [out] <auto>
// [opt] 0 1
// Find r and s, so that ra + sb = gcd(a, b)
int egcd(int a, int b, int* r, int* s)
{
	int x = 0, lastx = 1;
	int y = 1, lasty = 0;

	while (b != 0)
	{
		int quot = a / b;

		int temp = b;
		b = a % b;
		a = temp;

		temp = x;
		x = lastx - quot * x;
		lastx = temp;

		temp = y;
		y = lasty - quot * y;
		lasty = temp;
	}

	*r = lastx;
	*s = lasty;
	return a;
}

int main(int argc, char* argv[])
{
	int a, b;
	scanf("%i", &a); // [in] 234
	scanf("%i", &b); // [in] 882

	int r, s, g;
	g = egcd(a, b, &r, &s);

	printf("%i*%i + %i*%i = %i\n", r, a, s, b, g);

	return 0;
}

