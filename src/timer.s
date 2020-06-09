	.file	"timer.c"
	.option nopic
	.attribute arch, "rv64i2p0_m2p0_a2p0_f2p0_d2p0_c2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	1
	.globl	timer_pending
	.type	timer_pending, @function
timer_pending:
	addi	sp,sp,-32
	sd	s0,24(sp)
	addi	s0,sp,32
 #APP
# 8 "timer.c" 1
	csrr a5, mip
# 0 "" 2
 #NO_APP
	sd	a5,-24(s0)
	ld	a5,-24(s0)
	sw	a5,-28(s0)
	lw	a5,-28(s0)
	andi	a5,a5,128
	sext.w	a5,a5
	sgt	a5,a5,zero
	andi	a5,a5,0xff
	mv	a0,a5
	ld	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.size	timer_pending, .-timer_pending
	.align	1
	.globl	set_timer
	.type	set_timer, @function
set_timer:
	addi	sp,sp,-48
	sd	s0,40(sp)
	addi	s0,sp,48
	sd	a0,-40(s0)
	lla	a5,mtimecmp
	ld	a5,0(a5)
	sd	a5,-24(s0)
	ld	a5,-24(s0)
	ld	a4,-40(s0)
	sd	a4,0(a5)
	nop
	ld	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.size	set_timer, .-set_timer
	.align	1
	.globl	clear_timer
	.type	clear_timer, @function
clear_timer:
	addi	sp,sp,-32
	sd	s0,24(sp)
	addi	s0,sp,32
	lla	a5,mtimecmp
	ld	a5,0(a5)
	sd	a5,-24(s0)
	ld	a5,-24(s0)
	sd	zero,0(a5)
	nop
	ld	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.size	clear_timer, .-clear_timer
	.ident	"GCC: (GNU) 9.2.0"
