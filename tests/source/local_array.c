#include <stdio.h>

// [out] <auto>
int main(int argc, char* argv[])
{
	char message[] = "Hello world!";
	message[11] = '?';
	printf("%s\n", message);
	return 0;
}

