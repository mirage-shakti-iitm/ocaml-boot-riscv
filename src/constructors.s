	.file	"constructors.c"
	.option nopic
	.attribute arch, "rv64i2p0_m2p0_a2p0_f2p0_d2p0_c2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	1
	.globl	run_constructors
	.type	run_constructors, @function
run_constructors:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	lui	a5,%hi(_fbss)
	addi	a5,a5,%lo(_fbss)
	sd	a5,-24(s0)
	j	.L2
.L3:
	ld	a5,-24(s0)
	sb	zero,0(a5)
	ld	a5,-24(s0)
	addi	a5,a5,1
	sd	a5,-24(s0)
.L2:
	ld	a4,-24(s0)
	lui	a5,%hi(_ebss)
	addi	a5,a5,%lo(_ebss)
	bne	a4,a5,.L3
	lui	a5,%hi(__CTORS_START)
	addi	a5,a5,%lo(__CTORS_START)
	sd	a5,-32(s0)
	j	.L4
.L5:
	ld	a5,-32(s0)
	ld	a5,0(a5)
	jalr	a5
	ld	a5,-32(s0)
	addi	a5,a5,8
	sd	a5,-32(s0)
.L4:
	ld	a4,-32(s0)
	lui	a5,%hi(__CTORS_END)
	addi	a5,a5,%lo(__CTORS_END)
	bne	a4,a5,.L5
	nop
	nop
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	run_constructors, .-run_constructors
	.ident	"GCC: (GNU) 9.2.0"
