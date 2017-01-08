#include <stdio.h>

// [out] <auto>
// [opt] 1
int main(int argc, char* argv[])
{
	int a;
	double b, c;
	scanf("%i", &a); // [in] 5
	scanf("%lf", &b); // [in] 1.0
	scanf("%lf", &c); // [in] 2.0
	printf("%f\n", (a < 10) ? b : c);
	return 0;
}

