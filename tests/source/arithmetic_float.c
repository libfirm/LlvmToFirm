#include <stdio.h>

// [opt] 0 1
// [out] <auto>
int main(int argc, char* argv[])
{
	float a, b;

	printf("a =\n");
	scanf("%f", &a); // [in] -1782.726
	printf("b =\n");
	scanf("%f", &b); // [in] 148.821
	printf("\n");
	
	printf("    a     + b     = %f\n", (double)(    a     + b));
	printf("2 * a     - b     = %f\n", (double)(2 * a     - b));
	printf("3 * a     + a / b = %f\n", (double)(3 * a     + a / b));
	printf("4 * a * a - b     = %f\n", (double)(4 * a * a - b));
	printf("\n");
	
	printf("a / b = %f\n", (double)(a / b));
	// frem isn't tested. don't know how.

	return 0;
}
