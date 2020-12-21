	.file	"f25.cc"
	.text
	.globl	_Z1fPi
	.type	_Z1fPi, @function
_Z1fPi:
.LFB84:
	endbr64
	subq	$24, %rsp
	movl	(%rdi), %eax
	movl	%eax, 12(%rsp)
	movl	4(%rdi), %eax
	movl	%eax, 8(%rsp)
	movl	8(%rdi), %eax
	movw	%ax, 6(%rsp)
	movl	12(%rdi), %eax
	movw	%ax, 4(%rsp)
	movl	16(%rdi), %eax
	movb	%al, 3(%rsp)
	movl	20(%rdi), %eax
	movb	%al, 2(%rsp)
	leaq	12(%rsp), %rdi
	movl	$4, %esi
	call	_Z7hexdumpPKvm@PLT
	leaq	8(%rsp), %rdi
	movl	$4, %esi
	call	_Z7hexdumpPKvm@PLT
	leaq	6(%rsp), %rdi
	movl	$2, %esi
	call	_Z7hexdumpPKvm@PLT
	leaq	4(%rsp), %rdi
	movl	$2, %esi
	call	_Z7hexdumpPKvm@PLT
	leaq	3(%rsp), %rdi
	movl	$1, %esi
	call	_Z7hexdumpPKvm@PLT
	leaq	2(%rsp), %rdi
	movl	$1, %esi
	call	_Z7hexdumpPKvm@PLT
	addq	$24, %rsp
	ret
.LFE84:
	.size	_Z1fPi, .-_Z1fPi
	.globl	main
	.type	main, @function
main:
.LFB85:
	endbr64
	pushq	%rbp
	pushq	%rbx
	subq	$40, %rsp
	movq	%rsp, %rbx
	leaq	24(%rsp), %rbp
.L4:
	call	random@PLT
	movl	%eax, (%rbx)
	addq	$4, %rbx
	cmpq	%rbp, %rbx
	jne	.L4
	movq	%rsp, %rdi
	call	_Z1fPi
	movl	$0, %eax
	addq	$40, %rsp
	popq	%rbx
	popq	%rbp
	ret
.LFE85:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 9.3.0-10ubuntu2) 9.3.0"
	.section	.note.GNU-stack,"",@progbits
