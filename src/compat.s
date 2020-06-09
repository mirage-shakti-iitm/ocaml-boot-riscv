	.file	"compat.c"
	.option nopic
	.attribute arch, "rv64i2p0_m2p0_a2p0_f2p0_d2p0_c2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	1
	.globl	riscv_poweroff
	.type	riscv_poweroff, @function
riscv_poweroff:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	mv	a5,a0
	sw	a5,-20(s0)
	call	htif_poweroff
	.size	riscv_poweroff, .-riscv_poweroff
	.align	1
	.globl	riscv_write
	.type	riscv_write, @function
riscv_write:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	sd	a0,-24(s0)
	mv	a5,a1
	sw	a5,-28(s0)
	lw	a5,-28(s0)
	mv	a1,a5
	ld	a0,-24(s0)
	call	putstring
	nop
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	riscv_write, .-riscv_write
	.align	1
	.globl	riscv_clock_monotonic
	.type	riscv_clock_monotonic, @function
riscv_clock_monotonic:
	addi	sp,sp,-32
	sd	s0,24(sp)
	addi	s0,sp,32
	lla	a5,mtime
	ld	a5,0(a5)
	sd	a5,-24(s0)
	ld	a5,-24(s0)
	ld	a5,0(a5)
	mv	a0,a5
	ld	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.size	riscv_clock_monotonic, .-riscv_clock_monotonic
	.align	1
	.globl	riscv_wait
	.type	riscv_wait, @function
riscv_wait:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	addi	s0,sp,48
	sd	a0,-40(s0)
	ld	a5,-40(s0)
	sd	a5,-24(s0)
	ld	a0,-24(s0)
	call	set_timer
	nop
.L6:
	call	timer_pending
	mv	a5,a0
	xori	a5,a5,1
	andi	a5,a5,0xff
	bne	a5,zero,.L6
	call	clear_timer
	nop
	ld	ra,40(sp)
	ld	s0,32(sp)
	addi	sp,sp,48
	jr	ra
	.size	riscv_wait, .-riscv_wait
	.ident	"GCC: (GNU) 9.2.0"
