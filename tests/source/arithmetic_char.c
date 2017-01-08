#include <stdio.h>

// [opt] 0 1
// [out] <auto>
int main(int argc, char* argv[])
{
	int x, y;

	printf("a =\n");
	scanf("%i", &x); // [in] -135
	printf("b =\n");
	scanf("%i", &y); // [in] 83
	printf("\n");
	
	char          a = (char)x;
	char          b = (char)y;
	unsigned char c = (unsigned char)a;
	unsigned char d = (unsigned char)b;
	
	printf("    a     + b     = %i\n", (int)(char)(    a     + b));
	printf("2 * a     - b     = %i\n", (int)(char)(2 * a     - b));
	printf("3 * a     + a / b = %i\n", (int)(char)(3 * a     + a / b));
	printf("4 * a * a - b     = %i\n", (int)(char)(4 * a * a - b));
	printf("\n");
	
	printf("Signed:   a / b = %i\n",  (int)(char)(a / b));
	printf("Signed:   a %% b = %i\n", (int)(char)(a % b));
	printf("Unsigned: a / b = %i\n",  (int)(unsigned char)(c / d));
	printf("Unsigned: a %% b = %i\n", (int)(unsigned char)(c % d));

	return 0;
}
