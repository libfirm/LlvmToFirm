#include <stdio.h>

// [out] <auto>
void getNumber(int* ret)
{
	int num;
	scanf("%i", &num); // [in] 987
	*ret = num;
}

int main(int argc, char* argv[])
{
	int ret;
	getNumber(&ret);
	printf("%i\n", ret);
	return 0;
}

