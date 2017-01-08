#include <stdio.h>

// [out] <auto>
// [opt] 0 1
int fibonacci(int num)
{
	if (num == 0) return 0;
	if (num == 1) return 1;
	return fibonacci(num - 1) + fibonacci(num - 2);
}

int main(int argc, char* argv[])
{
	int num;
	scanf("%i", &num); // [in] 20

	int i;
	for (i = 0; i < num; i++)
	{
		printf("%i\n", fibonacci(i));
	}

	return 0;
}

