	.file	"f29.cc"
	.text
	.globl	_Z1fii
	.type	_Z1fii, @function
_Z1fii:
.LFB0:
	endbr64
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$48, %rsp
	movl	%edi, -36(%rbp)
	movl	%esi, -40(%rbp)
	movl	-36(%rbp), %eax
	movl	%eax, %edi
	call	_Z1gi@PLT
	movl	%eax, -20(%rbp)
	movl	-40(%rbp), %eax
	movl	%eax, %edi
	call	_Z1gi@PLT
	movl	%eax, -16(%rbp)
	movl	-20(%rbp), %edx
	movl	-16(%rbp), %eax
	addl	%edx, %eax
	movl	%eax, %edi
	call	_Z1gi@PLT
	movl	%eax, -12(%rbp)
	movl	-16(%rbp), %edx
	movl	-12(%rbp), %eax
	addl	%edx, %eax
	movl	%eax, %edi
	call	_Z1gi@PLT
	movl	%eax, -8(%rbp)
	movl	-12(%rbp), %edx
	movl	-8(%rbp), %eax
	addl	%edx, %eax
	movl	%eax, %edi
	call	_Z1gi@PLT
	movl	%eax, -4(%rbp)
	movl	-8(%rbp), %edx
	movl	-4(%rbp), %eax
	addl	%edx, %eax
	movl	%eax, %edi
	call	_Z1gi@PLT
	leave
	ret
.LFE0:
	.size	_Z1fii, .-_Z1fii
	.ident	"GCC: (Ubuntu 9.3.0-10ubuntu2) 9.3.0"
	.section	.note.GNU-stack,"",@progbits
