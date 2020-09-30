	.file	"f19.cc"
	.text
	.globl	_Z1flllllll
	.type	_Z1flllllll, @function
_Z1flllllll:
.LFB0:
	endbr64
	subq	$40, %rsp
	movl	%edi, (%rsp)
	movl	%esi, 4(%rsp)
	movl	%edx, 8(%rsp)
	movl	%ecx, 12(%rsp)
	movl	%r8d, 16(%rsp)
	movl	%r9d, 20(%rsp)
	movq	48(%rsp), %rax
	movl	%eax, 24(%rsp)
	movq	%rsp, %rdi
	leaq	24(%rsp), %rsi
	call	_Z13process_arrayPKiS0_@PLT
	addq	$40, %rsp
	ret
.LFE0:
	.size	_Z1flllllll, .-_Z1flllllll
	.ident	"GCC: (Ubuntu 9.3.0-10ubuntu2) 9.3.0"
	.section	.note.GNU-stack,"",@progbits
