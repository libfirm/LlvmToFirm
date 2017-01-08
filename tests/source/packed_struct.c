#include <stdio.h>

struct TestStruct
{
	char  int8;
	short int16;
	int   int32;
} __attribute__((__packed__));

// [out] <auto>
// [opt] 0 1
int main(int argc, char* argv[])
{
	struct TestStruct ts;
	ts.int8  = 123;
	ts.int16 = 8937;
	ts.int32 = 98733;

	printf("%i\n", *(int*)&ts);
	return 0;
}

