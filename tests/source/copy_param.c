#include <stdio.h>

// [out] <auto>
// [opt] 0 1
struct TestStruct
{
	int int32[10];
	float flt[10];
};

void showData(struct TestStruct ts)
{
	int i;
	for (i = 0; i < 10; i++)
	{
		ts.int32[i] = -i;
		ts.flt[i] = (float)-i;
	}
}

int main(int argc, char argv[])
{
	struct TestStruct ts;

	int i;
	for (i = 0; i < 10; i++)
	{
		ts.int32[i] = i;
		ts.flt[i] = (float)i;
	}
	
	showData(ts);

	for (i = 0; i < 10; i++)
	{
		printf("%i\n", ts.int32[i]);
		printf("%f\n", (double)ts.flt[i]);
	}

	return 0;
}

