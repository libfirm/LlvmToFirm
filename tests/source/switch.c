#include <stdio.h>
#define CASE(n) case n: b = n; break;

// [out] <auto>
int main()
{
	int a;
	do
	{
		scanf("%i", &a);

		int b = 0;

		switch (a)
		{
		};

		b = 0;
		switch (a)
		{
		CASE(-2)
		};

		printf("%i\n", b);

		b = 0;
		switch (a)
		{
		CASE(-2)
		CASE(2)
		};

		printf("%i\n", b);

		switch (a)
		{
		CASE(-2)
		CASE(2)  CASE(3)  CASE(5)  CASE(7)  CASE(11)
		CASE(13) CASE(17) CASE(19) CASE(23) CASE(29)
		case 30: b = 30;
		default: printf("%i\n", b); break;
		};

		printf("%i\n", b);
		b = 0;

		switch (a)
		{
		CASE(2)  CASE(3)  CASE(5)  CASE(7)  CASE(11)
		CASE(13) CASE(17) CASE(19) CASE(23) CASE(29)
		case 30: b = 30;
		default: printf("%i\n", b); break;
		};

		printf("%i\n", b);
	}
	while (a != -1);

	return 0;
}

// [in]  0
// [in]  1
// [in]  2
// [in]  3
// [in]  4
// [in]  5
// [in]  6
// [in]  7
// [in]  8
// [in]  9
// [in] 10
// [in] 11
// [in] 12
// [in] 13
// [in] 14
// [in] 15
// [in] 16
// [in] 17
// [in] 18
// [in] 19
// [in] 20
// [in] 21
// [in] 22
// [in] 23
// [in] 24
// [in] 25
// [in] 26
// [in] 27
// [in] 28
// [in] 29
// [in] 30
// [in] -1

