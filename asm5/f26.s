	.file	"f26.cc"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"%d: %p\n"
	.text
	.globl	_Z1fi
	.type	_Z1fi, @function
_Z1fi:
.LFB84:
	endbr64
	pushq	%rbx
	subq	$16, %rsp
	movl	%edi, %edx
	movl	%edi, 12(%rsp)
	testl	%edi, %edi
	jle	.L2
	leaq	12(%rsp), %rbx
	movq	%rbx, %rcx
	leaq	.LC0(%rip), %rsi
	movl	$1, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	movl	12(%rsp), %eax
	leal	-1(%rax), %edi
	call	_Z1fi
	movq	%rbx, %rcx
	movl	12(%rsp), %edx
	leaq	.LC0(%rip), %rsi
	movl	$1, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
.L1:
	addq	$16, %rsp
	popq	%rbx
	ret
.L2:
	leaq	12(%rsp), %rcx
	leaq	.LC0(%rip), %rsi
	movl	$1, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	jmp	.L1
.LFE84:
	.size	_Z1fi, .-_Z1fi
	.globl	main
	.type	main, @function
main:
.LFB85:
	endbr64
	subq	$8, %rsp
	call	_Z1fi
	movl	$0, %eax
	addq	$8, %rsp
	ret
.LFE85:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 9.3.0-10ubuntu2) 9.3.0"
	.section	.note.GNU-stack,"",@progbits
