#include <stdio.h>

// [out] <auto>
int getNumber()
{
	int num;
	scanf("%i", &num); // [in] 12
	return num;
}

int main(int argc, char* argv[])
{
	printf("%i\n", getNumber());
	return 0;
}

