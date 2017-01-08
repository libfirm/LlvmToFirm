#include <stdio.h>

// [opt] 0 1
// [out] <auto>
int main(int argc, char* argv[])
{
	int num;
	scanf("%i", &num); // [in] 45
	
	printf("%i\n", num);
	printf("%i %x\n", num, num);
	printf("%i %x %o\n", num, num, num);
	printf("%i %x %o %X\n", num, num, num, num);
	return 0;
}
