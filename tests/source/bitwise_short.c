#include <stdio.h>

// [opt] 0 1
// [out] <auto>
int main(int argc, char* argv[])
{
	int x, y;

	printf("a =\n");
	scanf("%i", &x); // [in] -97329
	printf("b =\n");
	scanf("%i", &y); // [in] 23488
	printf("\n");

	short          a = (short)x;
	short          b = (short)y;
	unsigned short c = (unsigned short)a;
	unsigned short d = (unsigned short)b;

	printf("a ^ b             = %i\n", (int)(short)(a ^ b));
	printf("a | b             = %i\n", (int)(short)(a | b));
	printf("a & b             = %i\n", (int)(short)(a & b));
	printf("a << 7            = %i\n", (int)(short)(a << 7));
	printf("a << 12           = %i\n", (int)(short)(a << 12));
	printf("Signed: a >> 7    = %i\n", (int)(short)(a >> 7));
	printf("Signed: a >> 12   = %i\n", (int)(short)(a >> 12));
	printf("Unsigned: a >> 7  = %i\n", (int)(unsigned short)(c >> 7));
	printf("Unsigned: a >> 12 = %i\n", (int)(unsigned short)(c >> 12));
	printf("(a & b) ^ (a | b) = %i\n", (int)(short)((a & b) ^ (a | b)));

	return 0;
}
