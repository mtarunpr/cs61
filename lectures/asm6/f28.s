	.file	"f28.cc"
	.text
	.globl	_Z1fj
	.type	_Z1fj, @function
_Z1fj:
.LFB0:
	endbr64
	pushq	%rbx
	movl	%edi, %ebx
	testl	%edi, %edi
	jne	.L4
.L2:
	movl	%ebx, %eax
	popq	%rbx
	ret
.L4:
	leal	-1(%rdi), %edi
	call	_Z1fj
	addl	%eax, %ebx
	jmp	.L2
.LFE0:
	.size	_Z1fj, .-_Z1fj
	.ident	"GCC: (Ubuntu 9.3.0-10ubuntu2) 9.3.0"
	.section	.note.GNU-stack,"",@progbits
