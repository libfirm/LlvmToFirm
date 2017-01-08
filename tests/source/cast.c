#include <stdio.h>

// [opt] 0 1
// [out] <auto>
int main(int argc, char* argv[])
{
	int num;
	scanf("%i", &num); // [in] -897398

	char trunc = (char)num;
	trunc++;
	
	int sext = (int)trunc;
	unsigned int zext = (unsigned int)(unsigned char)trunc;
	
	printf("%i\n", (int)trunc);
	printf("%i\n", sext);
	printf("%i\n", (int)zext);
	
	void* inttoptr = (void*)num;
	printf("%p\n", inttoptr);
	// TODO: ptrtoint
	
	float fpnum;
	scanf("%f", &fpnum); // [in] 98349.929389
	
	double fpext = (double)fpnum;
	fpext += 1E100;
	
	float fptrunc = (float)fpext;
	
	printf("%E\n", fpext);
	printf("%E\n", (double)fptrunc);
	
	float negfpnum = -fpnum;
	
	unsigned int fptoui = (unsigned int)fpnum;
	int fptosi = (int)negfpnum;
	
	printf("%i\n", (int)fptoui);
	printf("%i\n", fptosi);

	float uitofp = (float)fptoui;
	float sitofp = (float)fptosi;
	
	printf("%f\n", (double)uitofp);
	printf("%f\n", (double)sitofp);
	return 0;
}
