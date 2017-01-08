#include <stdio.h>

// [opt] 0 1
// [out] <auto>
int main(int argc, char* argv[])
{
	int x, y;

	printf("a =\n");
	scanf("%i", &x); // [in] -8374
	printf("b =\n");
	scanf("%i", &y); // [in] 1773
	printf("\n");
	
	short          a = (short)x;
	short          b = (short)y;
	unsigned short c = (unsigned short)a;
	unsigned short d = (unsigned short)b;
	
	printf("    a     + b     = %i\n", (int)(short)(    a     + b));
	printf("2 * a     - b     = %i\n", (int)(short)(2 * a     - b));
	printf("3 * a     + a / b = %i\n", (int)(short)(3 * a     + a / b));
	printf("4 * a * a - b     = %i\n", (int)(short)(4 * a * a - b));
	printf("\n");
	
	printf("Signed:   a / b = %i\n",  (int)(short)(a / b));
	printf("Signed:   a %% b = %i\n", (int)(short)(a % b));
	printf("Unsigned: a / b = %i\n",  (int)(unsigned short)(c / d));
	printf("Unsigned: a %% b = %i\n", (int)(unsigned short)(c % d));

	return 0;
}
