#include <stdio.h>

// [opt] 0 1
// [out] <auto>
int main(int argc, char* argv[])
{
	int a, b;

	printf("a =\n");
	scanf("%i", &a); // [in] -73322
	printf("b =\n");
	scanf("%i", &b); // [in] 1292
	printf("\n");
	
	unsigned int c = (unsigned int)a;
	unsigned int d = (unsigned int)b;
	
	printf("    a     + b     = %i\n",     a     + b);
	printf("2 * a     - b     = %i\n", 2 * a     - b);
	printf("3 * a     + a / b = %i\n", 3 * a     + a / b);
	printf("4 * a * a - b     = %i\n", 4 * a * a - b);
	printf("\n");
	
	printf("Signed:   a / b = %i\n",  a / b);
	printf("Signed:   a %% b = %i\n", a % b);
	printf("Unsigned: a / b = %i\n",  (int)(c / d));
	printf("Unsigned: a %% b = %i\n", (int)(c % d));

	return 0;
}
