	.file	"mmul.c"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"r"
.LC1:
	.string	"matrix.h"
.LC2:
	.string	"fh != 0"
.LC3:
	.string	"rv == 1"
.LC4:
	.string	"rv == (size_t)(nn * nn)"
	.text
	.p2align 4
	.type	read_matrix, @function
read_matrix:
.LFB41:
	.cfi_startproc
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	leaq	.LC0(%rip), %rsi
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	subq	$16, %rsp
	.cfi_def_cfa_offset 48
	movq	%fs:40, %rax
	movq	%rax, 8(%rsp)
	xorl	%eax, %eax
	call	fopen@PLT
	testq	%rax, %rax
	je	.L8
	movq	%rsp, %rdi
	movq	%rax, %rcx
	movl	$1, %edx
	movl	$8, %esi
	movq	%rax, %rbx
	call	fread@PLT
	cmpq	$1, %rax
	jne	.L9
	movq	(%rsp), %rbp
	movl	$16, %esi
	movl	$1, %edi
	call	calloc@PLT
	movl	$4, %esi
	movq	%rbp, (%rax)
	imulq	%rbp, %rbp
	movq	%rax, %r12
	movq	%rbp, %rdi
	call	calloc@PLT
	movq	%rbp, %rdx
	movq	%rbx, %rcx
	movl	$4, %esi
	movq	%rax, 8(%r12)
	movq	%rax, %rdi
	call	fread@PLT
	movq	%rax, %rdx
	movq	(%rsp), %rax
	imulq	%rax, %rax
	cmpq	%rdx, %rax
	jne	.L10
	movq	%rbx, %rdi
	call	fclose@PLT
	movq	8(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L11
	addq	$16, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 32
	movq	%r12, %rax
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
.L8:
	.cfi_restore_state
	leaq	__PRETTY_FUNCTION__.1(%rip), %rcx
	movl	$38, %edx
	leaq	.LC1(%rip), %rsi
	leaq	.LC2(%rip), %rdi
	call	__assert_fail@PLT
.L11:
	call	__stack_chk_fail@PLT
.L10:
	leaq	__PRETTY_FUNCTION__.1(%rip), %rcx
	movl	$46, %edx
	leaq	.LC1(%rip), %rsi
	leaq	.LC4(%rip), %rdi
	call	__assert_fail@PLT
.L9:
	leaq	__PRETTY_FUNCTION__.1(%rip), %rcx
	movl	$41, %edx
	leaq	.LC1(%rip), %rsi
	leaq	.LC3(%rip), %rdi
	call	__assert_fail@PLT
	.cfi_endproc
.LFE41:
	.size	read_matrix, .-read_matrix
	.section	.rodata.str1.1
.LC5:
	.string	"mmul.c"
.LC6:
	.string	"aa->size == bb->size"
	.text
	.p2align 4
	.globl	mmul
	.type	mmul, @function
mmul:
.LFB44:
	.cfi_startproc
	endbr64
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$8, %rsp
	.cfi_def_cfa_offset 64
	movq	(%rdi), %rbx
	cmpq	(%rsi), %rbx
	jne	.L21
	movq	%rdi, %r12
	movq	%rsi, %r13
	movl	$1, %edi
	movl	$16, %esi
	call	calloc@PLT
	movq	%rbx, %rdi
	movl	$4, %esi
	movq	%rbx, (%rax)
	imulq	%rbx, %rdi
	movq	%rax, %rbp
	call	calloc@PLT
	movq	%rax, 8(%rbp)
	movq	%rax, %r11
	testq	%rbx, %rbx
	jle	.L12
	movq	8(%r12), %r10
	movq	8(%r13), %r14
	movl	%ebx, %r15d
	xorl	%r12d, %r12d
	leaq	0(,%rbx,4), %rsi
	leaq	(%r10,%rsi), %r13
	movq	%r13, %rdi
	.p2align 4,,10
	.p2align 3
.L15:
	movq	%r14, %r8
	movq	%r11, %rcx
	xorl	%r9d, %r9d
	.p2align 4,,10
	.p2align 3
.L18:
	movss	(%rcx), %xmm1
	movq	%r8, %rdx
	movq	%r10, %rax
	.p2align 4,,10
	.p2align 3
.L16:
	movss	(%rax), %xmm0
	mulss	(%rdx), %xmm0
	addq	$4, %rax
	addq	%rsi, %rdx
	addss	%xmm0, %xmm1
	movss	%xmm1, (%rcx)
	cmpq	%rax, %rdi
	jne	.L16
	addq	$1, %r9
	addq	$4, %rcx
	addq	$4, %r8
	cmpq	%r9, %rbx
	jne	.L18
	addl	$1, %r12d
	movq	%r13, %r10
	addq	%rsi, %rdi
	addq	%rsi, %r11
	cmpl	%r15d, %r12d
	je	.L12
	addq	%rsi, %r13
	jmp	.L15
.L12:
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%rbp, %rax
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
.L21:
	.cfi_restore_state
	leaq	__PRETTY_FUNCTION__.3(%rip), %rcx
	movl	$9, %edx
	leaq	.LC5(%rip), %rsi
	leaq	.LC6(%rip), %rdi
	call	__assert_fail@PLT
	.cfi_endproc
.LFE44:
	.size	mmul, .-mmul
	.section	.rodata.str1.1
.LC7:
	.string	"argc == 3 || argc == 4"
.LC8:
	.string	"%.01f "
.LC9:
	.string	"w"
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC10:
	.string	"rv == (size_t)(aa->size * aa->size)"
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB45:
	.cfi_startproc
	endbr64
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	leal	-3(%rdi), %eax
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$8, %rsp
	.cfi_def_cfa_offset 64
	cmpl	$1, %eax
	ja	.L34
	movl	%edi, %r13d
	movq	8(%rsi), %rdi
	movq	%rsi, %r12
	call	read_matrix
	movq	16(%r12), %rdi
	movq	%rax, %rbx
	call	read_matrix
	movq	%rbx, %rdi
	movq	%rax, %rsi
	call	mmul
	movq	%rax, %r15
	movq	(%rax), %rax
	leaq	-1(%rax), %rdx
	cmpq	$7, %rdx
	jbe	.L35
.L24:
	cmpl	$4, %r13d
	je	.L36
.L27:
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	xorl	%eax, %eax
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
.L35:
	.cfi_restore_state
	xorl	%ebx, %ebx
	leaq	.LC8(%rip), %rbp
	.p2align 4,,10
	.p2align 3
.L26:
	xorl	%r14d, %r14d
	.p2align 4,,10
	.p2align 3
.L25:
	imulq	%rbx, %rax
	movq	8(%r15), %rdx
	pxor	%xmm0, %xmm0
	movq	%rbp, %rsi
	movl	$2, %edi
	addq	%r14, %rax
	addq	$1, %r14
	cvtss2sd	(%rdx,%rax,4), %xmm0
	movl	$1, %eax
	call	__printf_chk@PLT
	movq	(%r15), %rax
	cmpq	%r14, %rax
	jg	.L25
	movl	$10, %edi
	addq	$1, %rbx
	call	putchar@PLT
	movq	(%r15), %rax
	cmpq	%rax, %rbx
	jl	.L26
	jmp	.L24
.L36:
	movq	24(%r12), %rdi
	leaq	.LC9(%rip), %rsi
	call	fopen@PLT
	movq	%rax, %rbx
	testq	%rax, %rax
	je	.L37
	movq	%rax, %rcx
	movl	$1, %edx
	movl	$8, %esi
	movq	%r15, %rdi
	call	fwrite@PLT
	subq	$1, %rax
	jne	.L38
	movq	(%r15), %rdx
	movq	8(%r15), %rdi
	movq	%rbx, %rcx
	movl	$4, %esi
	imulq	%rdx, %rdx
	call	fwrite@PLT
	movq	%rax, %rdx
	movq	(%r15), %rax
	imulq	%rax, %rax
	cmpq	%rdx, %rax
	jne	.L39
	movq	%rbx, %rdi
	call	fclose@PLT
	jmp	.L27
.L37:
	leaq	__PRETTY_FUNCTION__.0(%rip), %rcx
	movl	$58, %edx
	leaq	.LC1(%rip), %rsi
	leaq	.LC2(%rip), %rdi
	call	__assert_fail@PLT
.L38:
	leaq	__PRETTY_FUNCTION__.0(%rip), %rcx
	movl	$61, %edx
	leaq	.LC1(%rip), %rsi
	leaq	.LC3(%rip), %rdi
	call	__assert_fail@PLT
.L39:
	leaq	__PRETTY_FUNCTION__.0(%rip), %rcx
	movl	$64, %edx
	leaq	.LC1(%rip), %rsi
	leaq	.LC10(%rip), %rdi
	call	__assert_fail@PLT
.L34:
	leaq	__PRETTY_FUNCTION__.2(%rip), %rcx
	movl	$29, %edx
	leaq	.LC5(%rip), %rsi
	leaq	.LC7(%rip), %rdi
	call	__assert_fail@PLT
	.cfi_endproc
.LFE45:
	.size	main, .-main
	.section	.rodata
	.align 8
	.type	__PRETTY_FUNCTION__.0, @object
	.size	__PRETTY_FUNCTION__.0, 13
__PRETTY_FUNCTION__.0:
	.string	"write_matrix"
	.align 8
	.type	__PRETTY_FUNCTION__.1, @object
	.size	__PRETTY_FUNCTION__.1, 12
__PRETTY_FUNCTION__.1:
	.string	"read_matrix"
	.type	__PRETTY_FUNCTION__.2, @object
	.size	__PRETTY_FUNCTION__.2, 5
__PRETTY_FUNCTION__.2:
	.string	"main"
	.type	__PRETTY_FUNCTION__.3, @object
	.size	__PRETTY_FUNCTION__.3, 5
__PRETTY_FUNCTION__.3:
	.string	"mmul"
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04.1) 13.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
