#include <stdio.h>

void infiniteLoop()
{
	while (1)
	{
		printf("Hello world\n");
	}
}

// [opt] 0 1
// [out] <auto>
int main(int argc, char* argv[])
{
	return 0;
}

