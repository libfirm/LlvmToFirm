#include <stdio.h>

// [out] <auto>
// [opt] 0 1
union TestUnion
{
        int int32;
        float flt;
};

int main(int argc, char* argv[])
{
	union TestUnion tu;
        scanf("%i", &tu.int32); // [in] 982379473
        printf("%f\n", tu.flt);
        return 0;
}

