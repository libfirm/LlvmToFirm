#include <stdio.h>

// [opt] 0 1
// [out] <auto>
int main(int argc, char* argv[])
{
	int x, y;

	printf("a =\n");
	scanf("%i", &x); // [in] -923749782398
	printf("b =\n");
	scanf("%i", &y); // [in] 273498777
	printf("\n");

	long long          a = (long long)x;
	long long          b = (long long)y;
	unsigned long long c = (unsigned long long)a;
	unsigned long long d = (unsigned long long)b;

	printf("a ^ b             = %i\n", (int)(a ^ b));
	printf("a | b             = %i\n", (int)(a | b));
	printf("a & b             = %i\n", (int)(a & b));
	printf("a << 12           = %i\n", (int)(a << 12));
	printf("a << 41           = %i\n", (int)(a << 41));
	printf("Signed: a >> 12   = %i\n", (int)(a >> 12));
	printf("Signed: a >> 41   = %i\n", (int)(a >> 41));
	printf("Unsigned: a >> 12 = %i\n", (int)(c >> 12));
	printf("Unsigned: a >> 41 = %i\n", (int)(c >> 41));
	printf("(a & b) ^ (a | b) = %i\n", (int)((a & b) ^ (a | b)));

	return 0;
}
