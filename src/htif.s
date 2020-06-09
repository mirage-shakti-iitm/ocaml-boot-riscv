	.file	"htif.c"
	.option nopic
	.attribute arch, "rv64i2p0_m2p0_a2p0_f2p0_d2p0_c2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.globl	tohost
	.section	.htif,"aw"
	.align	3
	.type	tohost, @object
	.size	tohost, 8
tohost:
	.zero	8
	.globl	fromhost
	.align	3
	.type	fromhost, @object
	.size	fromhost, 8
fromhost:
	.zero	8
	.comm	htif_console_buf,4,4
	.section	.rodata
	.align	3
.LC0:
	.string	"htif.c"
	.align	3
.LC1:
	.string	"FROMHOST_DEV(fh) == 1"
	.align	3
.LC2:
	.string	"Assertion '%s' failed in file/line %s:%s\n"
	.align	3
.LC3:
	.string	"0"
	.text
	.align	1
	.type	__check_fromhost, @function
__check_fromhost:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	lla	a5,fromhost
	ld	a5,0(a5)
	sd	a5,-24(s0)
	ld	a5,-24(s0)
	beq	a5,zero,.L12
	lla	a5,fromhost
	sd	zero,0(a5)
	ld	a5,-24(s0)
	srli	a4,a5,56
	li	a5,1
	beq	a4,a5,.L4
	li	a3,29
	lla	a2,.LC0
	lla	a1,.LC1
	lla	a0,.LC2
	call	printf
.L5:
	j	.L5
.L4:
	ld	a5,-24(s0)
	slli	a5,a5,8
	srli	a5,a5,56
	beq	a5,zero,.L6
	li	a4,1
	beq	a5,a4,.L13
	j	.L11
.L6:
	ld	a5,-24(s0)
	andi	a5,a5,0xff
	sext.w	a5,a5
	addiw	a5,a5,1
	sext.w	a4,a5
	lla	a5,htif_console_buf
	sw	a4,0(a5)
	j	.L1
.L11:
	li	a3,37
	lla	a2,.LC0
	lla	a1,.LC3
	lla	a0,.LC2
	call	printf
.L9:
	j	.L9
.L12:
	nop
	j	.L1
.L13:
	nop
.L1:
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	__check_fromhost, .-__check_fromhost
	.align	1
	.type	__set_tohost, @function
__set_tohost:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	addi	s0,sp,48
	sd	a0,-24(s0)
	sd	a1,-32(s0)
	sd	a2,-40(s0)
	j	.L15
.L16:
	call	__check_fromhost
.L15:
	lla	a5,tohost
	ld	a5,0(a5)
	bne	a5,zero,.L16
	ld	a5,-24(s0)
	slli	a4,a5,56
	ld	a5,-32(s0)
	slli	a5,a5,48
	or	a4,a4,a5
	ld	a5,-40(s0)
	or	a4,a4,a5
	lla	a5,tohost
	sd	a4,0(a5)
	nop
	ld	ra,40(sp)
	ld	s0,32(sp)
	addi	sp,sp,48
	jr	ra
	.size	__set_tohost, .-__set_tohost
	.align	1
	.globl	htif_console_getchar
	.type	htif_console_getchar, @function
htif_console_getchar:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	call	__check_fromhost
	lla	a5,htif_console_buf
	lw	a5,0(a5)
	sw	a5,-20(s0)
	lw	a5,-20(s0)
	sext.w	a5,a5
	blt	a5,zero,.L18
	lla	a5,htif_console_buf
	li	a4,-1
	sw	a4,0(a5)
	li	a2,0
	li	a1,0
	li	a0,1
	call	__set_tohost
.L18:
	lw	a5,-20(s0)
	addiw	a5,a5,-1
	sext.w	a5,a5
	mv	a0,a5
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	htif_console_getchar, .-htif_console_getchar
	.align	1
	.type	do_tohost_fromhost, @function
do_tohost_fromhost:
	addi	sp,sp,-64
	sd	ra,56(sp)
	sd	s0,48(sp)
	addi	s0,sp,64
	sd	a0,-40(s0)
	sd	a1,-48(s0)
	sd	a2,-56(s0)
	ld	a2,-56(s0)
	ld	a1,-48(s0)
	ld	a0,-40(s0)
	call	__set_tohost
.L24:
	lla	a5,fromhost
	ld	a5,0(a5)
	sd	a5,-24(s0)
	ld	a5,-24(s0)
	beq	a5,zero,.L24
	ld	a5,-24(s0)
	srli	a5,a5,56
	ld	a4,-40(s0)
	bne	a4,a5,.L22
	ld	a5,-24(s0)
	slli	a5,a5,8
	srli	a5,a5,56
	ld	a4,-48(s0)
	bne	a4,a5,.L22
	lla	a5,fromhost
	sd	zero,0(a5)
	j	.L25
.L22:
	call	__check_fromhost
	j	.L24
.L25:
	nop
	ld	ra,56(sp)
	ld	s0,48(sp)
	addi	sp,sp,64
	jr	ra
	.size	do_tohost_fromhost, .-do_tohost_fromhost
	.align	1
	.globl	htif_syscall
	.type	htif_syscall, @function
htif_syscall:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	sd	a0,-24(s0)
	ld	a2,-24(s0)
	li	a1,0
	li	a0,0
	call	do_tohost_fromhost
	nop
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	htif_syscall, .-htif_syscall
	.align	1
	.globl	htif_console_putchar
	.type	htif_console_putchar, @function
htif_console_putchar:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	mv	a5,a0
	sb	a5,-17(s0)
	lbu	a5,-17(s0)
	mv	a2,a5
	li	a1,1
	li	a0,1
	call	__set_tohost
	nop
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	htif_console_putchar, .-htif_console_putchar
	.align	1
	.globl	htif_poweroff
	.type	htif_poweroff, @function
htif_poweroff:
	addi	sp,sp,-16
	sd	s0,8(sp)
	addi	s0,sp,16
.L29:
	lla	a5,fromhost
	sd	zero,0(a5)
	lla	a5,tohost
	li	a4,1
	sd	a4,0(a5)
	j	.L29
	.size	htif_poweroff, .-htif_poweroff
	.ident	"GCC: (GNU) 9.2.0"
