#include <stdio.h>

// [opt] 0 1
// [out] <auto>
int main(int argc, char* argv[])
{
	int x, y;

	printf("a =\n");
	scanf("%i", &x); // [in] -172
	printf("b =\n");
	scanf("%i", &y); // [in] 82
	printf("\n");

	char          a = (char)x;
	char          b = (char)y;
	unsigned char c = (unsigned char)a;
	unsigned char d = (unsigned char)b;

	printf("a ^ b             = %i\n", (int)(char)(a ^ b));
	printf("a | b             = %i\n", (int)(char)(a | b));
	printf("a & b             = %i\n", (int)(char)(a & b));
	printf("a << 2            = %i\n", (int)(char)(a << 2));
	printf("a << 5            = %i\n", (int)(char)(a << 5));
	printf("Signed: a >> 2    = %i\n", (int)(char)(a >> 2));
	printf("Signed: a >> 5    = %i\n", (int)(char)(a >> 5));
	printf("Unsigned: a >> 2  = %i\n", (int)(unsigned char)(c >> 2));
	printf("Unsigned: a >> 5  = %i\n", (int)(unsigned char)(c >> 5));
	printf("(a & b) ^ (a | b) = %i\n", (int)(char)((a & b) ^ (a | b)));

	return 0;
}
