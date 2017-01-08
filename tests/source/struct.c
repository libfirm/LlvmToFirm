#include <stdio.h>

// [opt] 0 1
// [out] <auto>

struct TestStruct2
{
	char int8;
	int int32;
};

struct TestStruct
{
	int int32;
	char int8;
	struct TestStruct2 ts2;
	float flt;
};

struct TestStruct s;

int main(int argc, char* argv[])
{
	scanf("%i", &s.ts2.int32); // [in] 345
	scanf("%i", &s.int32); // [in] 12

	s.int8 = 9;
	s.flt = 1.27E2;
	
	printf("%i, %i, %e\n", s.int32, s.int8, s.flt);
	
	return 0;
}
