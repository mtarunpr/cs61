	.file	"f24.cc"
	.text
	.globl	_Z1f2s1iS_
	.type	_Z1f2s1iS_, @function
_Z1f2s1iS_:
.LFB0:
	endbr64
	addl	%edi, %esi
	sarq	$32, %rdx
	leal	(%rsi,%rdx), %eax
	salq	$32, %rax
	ret
.LFE0:
	.size	_Z1f2s1iS_, .-_Z1f2s1iS_
	.ident	"GCC: (Ubuntu 9.3.0-10ubuntu2) 9.3.0"
	.section	.note.GNU-stack,"",@progbits
