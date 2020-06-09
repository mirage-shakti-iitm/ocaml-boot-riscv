	.file	"config.c"
	.option nopic
	.attribute arch, "rv64i2p0_m2p0_a2p0_f2p0_d2p0_c2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.globl	mem_size
	.section	.srodata,"a"
	.align	3
	.type	mem_size, @object
	.size	mem_size, 8
mem_size:
	.dword	2147483648
	.globl	clint_consts_msip
	.align	3
	.type	clint_consts_msip, @object
	.size	clint_consts_msip, 8
clint_consts_msip:
	.zero	8
	.globl	clint_consts_mtimecmp
	.align	3
	.type	clint_consts_mtimecmp, @object
	.size	clint_consts_mtimecmp, 8
clint_consts_mtimecmp:
	.dword	16384
	.globl	clint_consts_mtime
	.align	3
	.type	clint_consts_mtime, @object
	.size	clint_consts_mtime, 8
clint_consts_mtime:
	.dword	49144
	.globl	clint_base
	.align	3
	.type	clint_base, @object
	.size	clint_base, 8
clint_base:
	.dword	33554432
	.globl	msip
	.align	3
	.type	msip, @object
	.size	msip, 8
msip:
	.dword	33554432
	.globl	mtimecmp
	.align	3
	.type	mtimecmp, @object
	.size	mtimecmp, 8
mtimecmp:
	.dword	33570816
	.globl	mtime
	.align	3
	.type	mtime, @object
	.size	mtime, 8
mtime:
	.dword	33603576
	.globl	stack_size
	.align	3
	.type	stack_size, @object
	.size	stack_size, 8
stack_size:
	.dword	4096
	.globl	stack_shift
	.align	1
	.type	stack_shift, @object
	.size	stack_shift, 2
stack_shift:
	.half	12
	.globl	print_buf_size
	.align	3
	.type	print_buf_size, @object
	.size	print_buf_size, 8
print_buf_size:
	.dword	256
	.ident	"GCC: (GNU) 9.2.0"
