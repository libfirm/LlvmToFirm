	.file	"invalid_div_2.bc"


	.text
	.align	16
	.globl	main
	.type	main,@function
main:                                                       # @main
.LBB1_0:                                                    # %entry
	pushl	%ebx
	subl	$16, %esp
	leal	8(%esp), %eax
	movl	%eax, 4(%esp)
	movl	$.L.str, (%esp)
	call	__isoc99_scanf
	leal	12(%esp), %eax
	movl	%eax, 4(%esp)
	movl	$.L.str, (%esp)
	call	__isoc99_scanf
	movzbl	8(%esp), %eax
	divb	12(%esp)
	movb	%ah, %bl
	movzbl	%al, %eax
	movl	%eax, 4(%esp)
	movl	$.L.str1, (%esp)
	call	printf
	movzbl	%bl, %eax
	movl	%eax, 4(%esp)
	movl	$.L.str2, (%esp)
	call	printf
	xorl	%eax, %eax
	addl	$16, %esp
	popl	%ebx
	ret
	.size	main, .-main
	.type	.L.str,@object
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:                                                     # @.str
	.asciz	"%i"
	.size	.L.str, 3
	.type	.L.str1,@object
	.section	.rodata.str1.16,"aMS",@progbits,1
.L.str1:                                                    # @.str1
	.asciz	"Unsigned: a / b = %i\n"
	.size	.L.str1, 22
	.type	.L.str2,@object
.L.str2:                                                    # @.str2
	.asciz	"Unsigned: a %% b = %i\n"
	.size	.L.str2, 23

	.section	.note.GNU-stack,"",@progbits
