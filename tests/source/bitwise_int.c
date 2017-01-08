#include <stdio.h>

// [opt] 0 1
// [out] <auto>
int main(int argc, char* argv[])
{
	int a, b;

	printf("a =\n");
	scanf("%i", &a); // [in] -87238497
	printf("b =\n");
	scanf("%i", &b); // [in] 897983
	printf("\n");

	unsigned int c = (unsigned int)a;
	unsigned int d = (unsigned int)b;

	printf("a ^ b             = %i\n", a ^ b);
	printf("a | b             = %i\n", a | b);
	printf("a & b             = %i\n", a & b);
	printf("a << 5            = %i\n", a << 5);
	printf("a << 20           = %i\n", a << 20);
	printf("Signed: a >> 5    = %i\n", a >> 5);
	printf("Signed: a >> 20   = %i\n", a >> 20);
	printf("Unsigned: a >> 5  = %i\n", (int)(c >> 5));
	printf("Unsigned: a >> 20 = %i\n", (int)(c >> 20));
	printf("(a & b) ^ (a | b) = %i\n", (a & b) ^ (a | b));

	return 0;
}
