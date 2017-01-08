#include <stdio.h>

// [opt] 0 1
// [out] <auto>
int main(int argc, char* argv[])
{
	float x, y;

	printf("a =\n");
	scanf("%f", &x); // [in] -38738.0912
	printf("b =\n");
	scanf("%f", &y); // [in] 2873.7987
	printf("\n");
	
	double a = (double)x;
	double b = (double)y;
	
	printf("    a     + b     = %f\n",     a     + b);
	printf("2 * a     - b     = %f\n", 2 * a     - b);
	printf("3 * a     + a / b = %f\n", 3 * a     + a / b);
	printf("4 * a * a - b     = %f\n", 4 * a * a - b);
	printf("\n");
	
	printf("a / b = %f\n", a / b);
	// frem isn't tested. don't know how.

	return 0;
}
