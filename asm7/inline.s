	.file	"inline.cc"
	.text
	.globl	_Z1fi
	.type	_Z1fi, @function
_Z1fi:
.LFB0:
	endbr64
	movslq	%edi, %rax
	movl	%edi, %edx
	imulq	$1374389535, %rax, %rax
	sarl	$31, %edx
	sarq	$37, %rax
	subl	%edx, %eax
	imull	$100, %eax, %eax
	subl	%eax, %edi
	movl	%edi, %eax
	ret
.LFE0:
	.size	_Z1fi, .-_Z1fi
	.globl	_Z1gi
	.type	_Z1gi, @function
_Z1gi:
.LFB1:
	endbr64
	xorl	%eax, %eax
	ret
.LFE1:
	.size	_Z1gi, .-_Z1gi
	.ident	"GCC: (Ubuntu 9.3.0-10ubuntu2) 9.3.0"
	.section	.note.GNU-stack,"",@progbits
