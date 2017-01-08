	.section	.text
.Ltext0:
# -- Begin  main
.globl main
	.type	main, @function
main:
	/* .L54: preds: none, freq: 1.000000 */
	pushl %ebp                       /* ia32_PushT[297:14]  */
	movl %esp, %ebp                  /* be_CopyIu[300:16]  */
	subl $16, %esp                   /* be_IncSPIu[302:18]  */
	movl %edi, -8(%ebp)              /* ia32_StoreM[559:214]  */
	subl $0x4, %esp                  /* ia32_SubSPT[358:32]  */
	movl %esp, %edi                  /* ia32_SubSPT[358:32]  */
	subl $0x4, %esp                  /* ia32_SubSPT[360:34]  */
	movl %esp, %edx                  /* ia32_SubSPT[360:34]  */
	pushl %edx                       /* ia32_PushT[564:219]  */
	pushl $.str                      /* ia32_PushT[567:222]  */
	call __isoc99_scanf              /* ia32_CallT[371:45]  */
	movl %edi, 4(%esp)               /* ia32_StoreM[402:76]  */
	movl $.str1, (%esp)              /* ia32_StoreM[400:74]  */
	call __isoc99_scanf              /* ia32_CallT[403:77]  */
	pushl %edx                       /* ia32_PushT[562:217]  */
	flds (%edi)                      /* ia32_fldT[438:108]  */
	faddl .LC1                       /* ia32_faddE[441:111]  */
	fstl -16(%ebp)                   /* ia32_fstM[558:213]  */
	fstpl 4(%esp)                    /* ia32_fstpM[442:112]  */
	movl $.str2, (%esp)              /* ia32_StoreM[432:106]  */
	call printf                      /* ia32_CallT[443:113]  */
	fldl -16(%ebp)                   /* ia32_fldT[556:211]  */
	fstpl 4(%esp)                    /* ia32_fstpM[473:143]  */
	movl $.str2, (%esp)              /* ia32_StoreM[472:142]  */
	call printf                      /* ia32_CallT[474:144]  */
	xorl %eax, %eax                  /* ia32_Xor0Iu[560:215]  */
	movl -8(%ebp), %edi              /* ia32_LoadT[554:209]  */
	movl %ebp, %esp                  /* be_CopyIu[320:176]  */
	popl %ebp                        /* ia32_PopEbpT[321:177]  */
	ret                              /* be_ReturnX[325:166]  */
	.size	main, .-main
# -- End  main

	.section	.data
	.type	.str, @object
	.size	.str, 3
.str:
	.byte	0x25
	.byte	0x69
	.byte	0x00
	.type	.str1, @object
	.size	.str1, 3
.str1:
	.byte	0x25
	.byte	0x66
	.byte	0x00
	.type	.str2, @object
	.size	.str2, 4
.str2:
	.byte	0x25
	.byte	0x45
	.byte	0x0a
	.byte	0x00
	.section	.rodata
	.p2align	3
	.type	.LC1, @object
	.size	.LC1, 8
.LC1:
	.quad	0x54b249ad2594c37d
