#include <stdio.h>

struct TestStruct
{
	int bit          : 1;
	int nibble       : 4;  // 5
	int tenbits      : 10; // 15
	int fourteenbits : 14; // 29
	int threebits    : 3;  // 32
};

// [out] <auto>
// [opt] 0
int main(int argc, char* argv[])
{
	struct TestStruct ts;

	ts.bit          = 1;
	ts.nibble       = 12;
	ts.tenbits      = 123;
	ts.fourteenbits = 1234;
	ts.threebits    = 1;

	printf("%i\n", *(int*)&ts);

	return 0;
}

