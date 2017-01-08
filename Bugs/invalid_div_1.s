	.file	"invalid_div_1.bc"


	.text
	.align	16
	.globl	main
	.type	main,@function
main:                                                       # @main
.LBB1_0:                                                    # %entry
	subl	$20, %esp
	leal	12(%esp), %eax
	movl	%eax, 4(%esp)
	movl	$.L.str, (%esp)
	call	__isoc99_scanf
	leal	16(%esp), %eax
	movl	%eax, 4(%esp)
	movl	$.L.str, (%esp)
	call	__isoc99_scanf
	movb	12(%esp), %al
	movb	%al, 10(%esp)
	movb	16(%esp), %cl
	movb	%cl, 11(%esp)
	movzbl	10(%esp), %eax
	divb	%cl
	movzbl	%ah, %eax
	movl	%eax, 4(%esp)
	movl	$.L.str1, (%esp)
	call	printf
	xorl	%eax, %eax
	addl	$20, %esp
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
	.asciz	"Unsigned: a %% b = %i\n"
	.size	.L.str1, 23

	.section	.note.GNU-stack,"",@progbits
