#include <stdio.h>

// [opt] 0 1
// [out] <auto>
int main(int argc, char* argv[])
{
	int num;
	scanf("%i", &num); // [in] 12
	
	int i;
	for (i = 0; i < num; i++)
	{
		printf("loop %i\n", i);
	}

	return 0;
}
