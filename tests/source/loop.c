#include <stdio.h>

// [opt] 0 1
// [out] <auto>
int main(int argc, char* argv[])
{
	int a, b;
	scanf("%i", &a); // [in] 6
  scanf("%i", &b); // [in] 3
	
  int z = 1;
	int i;
	for (i = 0; i < a; i++)
	{
    printf("loop 1: %i\n", i, z);

    int j = 0;
    while (j < i)
    {
      printf("loop 2: %i, %i\n", j, z);
      z *= b;
      j++;
    }
	}

  do
  {
    printf("loop 3: %i\n", a);
    a--;
  }
  while (a > 0);

	return 0;
}
