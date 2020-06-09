	.file	"print.c"
	.option nopic
	.attribute arch, "rv64i2p0_m2p0_a2p0_f2p0_d2p0_c2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	1
	.globl	vprintf
	.type	vprintf, @function
vprintf:
	addi	sp,sp,-304
	sd	ra,296(sp)
	sd	s0,288(sp)
	addi	s0,sp,304
	sd	a0,-296(s0)
	sd	a1,-304(s0)
	addi	a5,s0,-280
	ld	a3,-304(s0)
	ld	a2,-296(s0)
	li	a1,256
	mv	a0,a5
	call	vsnprintf
	addi	a5,s0,-280
	mv	a0,a5
	call	strlen
	mv	a5,a0
	sw	a5,-20(s0)
	lw	a4,-20(s0)
	addi	a5,s0,-280
	mv	a1,a4
	mv	a0,a5
	call	putstring
	nop
	ld	ra,296(sp)
	ld	s0,288(sp)
	addi	sp,sp,304
	jr	ra
	.size	vprintf, .-vprintf
	.align	1
	.globl	printf
	.type	printf, @function
printf:
	addi	sp,sp,-112
	sd	ra,40(sp)
	sd	s0,32(sp)
	addi	s0,sp,48
	sd	a0,-40(s0)
	sd	a1,8(s0)
	sd	a2,16(s0)
	sd	a3,24(s0)
	sd	a4,32(s0)
	sd	a5,40(s0)
	sd	a6,48(s0)
	sd	a7,56(s0)
	addi	a5,s0,64
	sd	a5,-48(s0)
	ld	a5,-48(s0)
	addi	a5,a5,-56
	sd	a5,-24(s0)
	ld	a5,-24(s0)
	mv	a1,a5
	ld	a0,-40(s0)
	call	vprintf
	nop
	ld	ra,40(sp)
	ld	s0,32(sp)
	addi	sp,sp,112
	jr	ra
	.size	printf, .-printf
	.align	1
	.globl	putstring
	.type	putstring, @function
putstring:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	addi	s0,sp,48
	sd	a0,-40(s0)
	mv	a5,a1
	sw	a5,-44(s0)
	sw	zero,-20(s0)
	j	.L4
.L5:
	lwu	a5,-20(s0)
	ld	a4,-40(s0)
	add	a5,a4,a5
	lbu	a5,0(a5)
	mv	a0,a5
	call	htif_console_putchar
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sw	a5,-20(s0)
.L4:
	lw	a4,-20(s0)
	lw	a5,-44(s0)
	sext.w	a4,a4
	sext.w	a5,a5
	bltu	a4,a5,.L5
	nop
	nop
	ld	ra,40(sp)
	ld	s0,32(sp)
	addi	sp,sp,48
	jr	ra
	.size	putstring, .-putstring
	.ident	"GCC: (GNU) 9.2.0"
