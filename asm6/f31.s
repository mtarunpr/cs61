	.file	"f31.cc"
	.text
	.globl	_Z1fPKii
	.type	_Z1fPKii, @function
_Z1fPKii:
.LFB0:
	endbr64
	testl	%esi, %esi
	jle	.L4
	leal	-1(%rsi), %edx
	leaq	4(%rdi), %rax
	xorl	%r8d, %r8d
	leaq	(%rax,%rdx,4), %rcx
	movq	%rcx, %rsi
	subq	%rdi, %rsi
	subq	$4, %rsi
	shrq	$2, %rsi
	addq	$1, %rsi
	andl	$7, %esi
	je	.L3
	cmpq	$1, %rsi
	je	.L27
	cmpq	$2, %rsi
	je	.L28
	cmpq	$3, %rsi
	je	.L29
	cmpq	$4, %rsi
	je	.L30
	cmpq	$5, %rsi
	je	.L31
	cmpq	$6, %rsi
	jne	.L42
.L32:
	movslq	(%rdi), %r9
	addq	$4, %rdi
	addq	%r9, %r8
.L31:
	movslq	(%rdi), %r10
	addq	$4, %rdi
	addq	%r10, %r8
.L30:
	movslq	(%rdi), %r11
	addq	$4, %rdi
	addq	%r11, %r8
.L29:
	movslq	(%rdi), %rdx
	addq	$4, %rdi
	addq	%rdx, %r8
.L28:
	movslq	(%rdi), %rax
	addq	$4, %rdi
	addq	%rax, %r8
.L27:
	movslq	(%rdi), %rsi
	addq	$4, %rdi
	addq	%rsi, %r8
	cmpq	%rdi, %rcx
	je	.L1
.L3:
	movslq	(%rdi), %r9
	movslq	8(%rdi), %r10
	addq	$32, %rdi
	movslq	-20(%rdi), %r11
	movslq	-16(%rdi), %rdx
	addq	%r8, %r9
	movslq	-28(%rdi), %r8
	movslq	-12(%rdi), %rax
	movslq	-8(%rdi), %rsi
	addq	%r8, %r9
	movslq	-4(%rdi), %r8
	addq	%r10, %r9
	addq	%r11, %r9
	addq	%rdx, %r9
	addq	%rax, %r9
	addq	%rsi, %r9
	addq	%r9, %r8
	cmpq	%rdi, %rcx
	jne	.L3
.L1:
	movq	%r8, %rax
	ret
.L42:
	movslq	(%rdi), %r8
	movq	%rax, %rdi
	jmp	.L32
.L4:
	xorl	%r8d, %r8d
	movq	%r8, %rax
	ret
.LFE0:
	.size	_Z1fPKii, .-_Z1fPKii
	.ident	"GCC: (Ubuntu 9.3.0-10ubuntu2) 9.3.0"
	.section	.note.GNU-stack,"",@progbits
