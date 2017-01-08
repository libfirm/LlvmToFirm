#include <stdio.h>

// [opt] 0 1
// [out] <auto>
int main(int argc, char* argv[])
{
	int x, y;

	printf("a =\n");
	scanf("%i", &x); // [in] -236478488
	printf("b =\n");
	scanf("%i", &y); // [in] 1773546
	printf("\n");
	
	long long          a = (long long)x;
	long long          b = (long long)y;
	unsigned long long c = (unsigned long long)a;
	unsigned long long d = (unsigned long long)b;
	
	printf("    a     + b     = %i\n", (int)(    a     + b));
	printf("2 * a     - b     = %i\n", (int)(2 * a     - b));
	printf("3 * a     + a / b = %i\n", (int)(3 * a     + a / b));
	printf("4 * a * a - b     = %i\n", (int)(4 * a * a - b));
	printf("\n");
	
	printf("Signed:   a / b = %i\n",  (int)(a / b));
	printf("Signed:   a %% b = %i\n", (int)(a % b));
	printf("Unsigned: a / b = %i\n",  (int)(c / d));
	printf("Unsigned: a %% b = %i\n", (int)(c % d));

	return 0;
}
