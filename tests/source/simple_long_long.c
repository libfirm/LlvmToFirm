#include <stdio.h>

// [out] <auto>
unsigned long long div(unsigned long long a, unsigned long long b)
{
	return a / b;
}

int main(int argc, char* argv[])
{
	int a, b;
	scanf("%i", &a); // [in] 3948942
	scanf("%i", &b); // [in] -38734223
	
	int c = (int)div(a, b);
	printf("%i\n", c);

	return 0;
}

