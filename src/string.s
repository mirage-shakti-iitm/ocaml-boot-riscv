	.file	"string.c"
	.option nopic
	.attribute arch, "rv64i2p0_m2p0_a2p0_f2p0_d2p0_c2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	1
	.globl	strcmp
	.type	strcmp, @function
strcmp:
	addi	sp,sp,-48
	sd	s0,40(sp)
	addi	s0,sp,48
	sd	a0,-40(s0)
	sd	a1,-48(s0)
	sw	zero,-20(s0)
.L7:
	lw	a5,-20(s0)
	ld	a4,-40(s0)
	add	a5,a4,a5
	lbu	a3,0(a5)
	lw	a5,-20(s0)
	ld	a4,-48(s0)
	add	a5,a4,a5
	lbu	a5,0(a5)
	mv	a4,a3
	beq	a4,a5,.L2
	lw	a5,-20(s0)
	ld	a4,-40(s0)
	add	a5,a4,a5
	lbu	a3,0(a5)
	lw	a5,-20(s0)
	ld	a4,-48(s0)
	add	a5,a4,a5
	lbu	a5,0(a5)
	mv	a4,a3
	bgeu	a4,a5,.L3
	li	a5,-1
	j	.L5
.L3:
	li	a5,1
	j	.L5
.L2:
	lw	a5,-20(s0)
	ld	a4,-40(s0)
	add	a5,a4,a5
	lbu	a5,0(a5)
	bne	a5,zero,.L6
	li	a5,0
	j	.L5
.L6:
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sw	a5,-20(s0)
	j	.L7
.L5:
	mv	a0,a5
	ld	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.size	strcmp, .-strcmp
	.align	1
	.globl	strcpy
	.type	strcpy, @function
strcpy:
	addi	sp,sp,-48
	sd	s0,40(sp)
	addi	s0,sp,48
	sd	a0,-40(s0)
	sd	a1,-48(s0)
	sw	zero,-20(s0)
.L11:
	lw	a5,-20(s0)
	ld	a4,-48(s0)
	add	a4,a4,a5
	lw	a5,-20(s0)
	ld	a3,-40(s0)
	add	a5,a3,a5
	lbu	a4,0(a4)
	sb	a4,0(a5)
	lw	a5,-20(s0)
	ld	a4,-48(s0)
	add	a5,a4,a5
	lbu	a5,0(a5)
	bne	a5,zero,.L9
	ld	a5,-40(s0)
	j	.L12
.L9:
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sw	a5,-20(s0)
	j	.L11
.L12:
	mv	a0,a5
	ld	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.size	strcpy, .-strcpy
	.align	1
	.globl	strlen
	.type	strlen, @function
strlen:
	addi	sp,sp,-48
	sd	s0,40(sp)
	addi	s0,sp,48
	sd	a0,-40(s0)
	sw	zero,-20(s0)
	j	.L14
.L15:
	ld	a5,-40(s0)
	addi	a5,a5,1
	sd	a5,-40(s0)
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sw	a5,-20(s0)
.L14:
	ld	a5,-40(s0)
	lbu	a5,0(a5)
	bne	a5,zero,.L15
	lw	a5,-20(s0)
	mv	a0,a5
	ld	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.size	strlen, .-strlen
	.align	1
	.globl	isstring
	.type	isstring, @function
isstring:
	addi	sp,sp,-32
	sd	s0,24(sp)
	addi	s0,sp,32
	mv	a5,a0
	sb	a5,-17(s0)
	lbu	a5,-17(s0)
	andi	a4,a5,0xff
	li	a5,64
	bleu	a4,a5,.L18
	lbu	a5,-17(s0)
	andi	a4,a5,0xff
	li	a5,90
	bgtu	a4,a5,.L18
	li	a5,1
	j	.L19
.L18:
	lbu	a5,-17(s0)
	andi	a4,a5,0xff
	li	a5,96
	bleu	a4,a5,.L20
	lbu	a5,-17(s0)
	andi	a4,a5,0xff
	li	a5,122
	bgtu	a4,a5,.L20
	li	a5,1
	j	.L19
.L20:
	lbu	a5,-17(s0)
	andi	a4,a5,0xff
	li	a5,47
	bleu	a4,a5,.L21
	lbu	a5,-17(s0)
	andi	a4,a5,0xff
	li	a5,57
	bgtu	a4,a5,.L21
	li	a5,1
	j	.L19
.L21:
	lbu	a5,-17(s0)
	andi	a5,a5,0xff
	beq	a5,zero,.L22
	lbu	a5,-17(s0)
	andi	a4,a5,0xff
	li	a5,32
	beq	a4,a5,.L22
	lbu	a5,-17(s0)
	andi	a4,a5,0xff
	li	a5,44
	beq	a4,a5,.L22
	lbu	a5,-17(s0)
	andi	a4,a5,0xff
	li	a5,45
	bne	a4,a5,.L23
.L22:
	li	a5,1
	j	.L19
.L23:
	li	a5,0
.L19:
	mv	a0,a5
	ld	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.size	isstring, .-isstring
	.align	1
	.globl	memset
	.type	memset, @function
memset:
	addi	sp,sp,-48
	sd	s0,40(sp)
	addi	s0,sp,48
	sd	a0,-40(s0)
	mv	a5,a1
	mv	a4,a2
	sw	a5,-44(s0)
	mv	a5,a4
	sw	a5,-48(s0)
	sw	zero,-20(s0)
	j	.L25
.L26:
	lwu	a5,-20(s0)
	ld	a4,-40(s0)
	add	a5,a4,a5
	lw	a4,-44(s0)
	andi	a4,a4,0xff
	sb	a4,0(a5)
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sw	a5,-20(s0)
.L25:
	lw	a4,-20(s0)
	lw	a5,-48(s0)
	sext.w	a4,a4
	sext.w	a5,a5
	bltu	a4,a5,.L26
	nop
	nop
	ld	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.size	memset, .-memset
	.align	1
	.globl	vsnprintf
	.type	vsnprintf, @function
vsnprintf:
	addi	sp,sp,-128
	sd	s0,120(sp)
	addi	s0,sp,128
	sd	a0,-104(s0)
	mv	a5,a1
	sd	a2,-120(s0)
	sd	a3,-128(s0)
	sw	a5,-108(s0)
	sb	zero,-17(s0)
	sb	zero,-18(s0)
	sw	zero,-24(s0)
	j	.L28
.L63:
	lbu	a5,-17(s0)
	andi	a5,a5,0xff
	beq	a5,zero,.L29
	ld	a5,-120(s0)
	lbu	a5,0(a5)
	sext.w	a5,a5
	addiw	a3,a5,-99
	sext.w	a4,a3
	li	a5,21
	bgtu	a4,a5,.L67
	slli	a5,a3,32
	srli	a5,a5,32
	slli	a4,a5,2
	lui	a5,%hi(.L32)
	addi	a5,a5,%lo(.L32)
	add	a5,a4,a5
	lw	a5,0(a5)
	jr	a5
	.section	.rodata
	.align	2
	.align	2
.L32:
	.word	.L37
	.word	.L36
	.word	.L67
	.word	.L67
	.word	.L67
	.word	.L67
	.word	.L67
	.word	.L67
	.word	.L67
	.word	.L35
	.word	.L67
	.word	.L67
	.word	.L67
	.word	.L34
	.word	.L67
	.word	.L67
	.word	.L33
	.word	.L67
	.word	.L67
	.word	.L67
	.word	.L67
	.word	.L31
	.text
.L35:
	li	a5,1
	sb	a5,-18(s0)
	j	.L61
.L34:
	li	a5,1
	sb	a5,-18(s0)
	lw	a5,-24(s0)
	addiw	a5,a5,1
	sw	a5,-24(s0)
	lw	a4,-24(s0)
	lw	a5,-108(s0)
	sext.w	a4,a4
	sext.w	a5,a5
	bgeu	a4,a5,.L39
	lw	a5,-24(s0)
	addiw	a5,a5,-1
	sext.w	a5,a5
	slli	a5,a5,32
	srli	a5,a5,32
	ld	a4,-104(s0)
	add	a5,a4,a5
	li	a4,48
	sb	a4,0(a5)
.L39:
	lw	a5,-24(s0)
	addiw	a5,a5,1
	sw	a5,-24(s0)
	lw	a4,-24(s0)
	lw	a5,-108(s0)
	sext.w	a4,a4
	sext.w	a5,a5
	bgeu	a4,a5,.L31
	lw	a5,-24(s0)
	addiw	a5,a5,-1
	sext.w	a5,a5
	slli	a5,a5,32
	srli	a5,a5,32
	ld	a4,-104(s0)
	add	a5,a4,a5
	li	a4,120
	sb	a4,0(a5)
.L31:
	lbu	a5,-18(s0)
	andi	a5,a5,0xff
	beq	a5,zero,.L40
	ld	a5,-128(s0)
	addi	a4,a5,8
	sd	a4,-128(s0)
	ld	a5,0(a5)
	j	.L41
.L40:
	ld	a5,-128(s0)
	addi	a4,a5,8
	sd	a4,-128(s0)
	lw	a5,0(a5)
.L41:
	sd	a5,-80(s0)
	lbu	a5,-18(s0)
	andi	a5,a5,0xff
	beq	a5,zero,.L42
	li	a5,15
	j	.L43
.L42:
	li	a5,7
.L43:
	sw	a5,-28(s0)
	j	.L44
.L48:
	lw	a5,-28(s0)
	slliw	a5,a5,2
	sext.w	a5,a5
	ld	a4,-80(s0)
	sra	a5,a4,a5
	sext.w	a5,a5
	andi	a5,a5,15
	sw	a5,-84(s0)
	lw	a5,-24(s0)
	addiw	a5,a5,1
	sw	a5,-24(s0)
	lw	a4,-24(s0)
	lw	a5,-108(s0)
	sext.w	a4,a4
	sext.w	a5,a5
	bgeu	a4,a5,.L45
	lw	a5,-84(s0)
	sext.w	a4,a5
	li	a5,9
	bgt	a4,a5,.L46
	lw	a5,-84(s0)
	andi	a5,a5,0xff
	addiw	a5,a5,48
	andi	a5,a5,0xff
	j	.L47
.L46:
	lw	a5,-84(s0)
	andi	a5,a5,0xff
	addiw	a5,a5,87
	andi	a5,a5,0xff
.L47:
	lw	a4,-24(s0)
	addiw	a4,a4,-1
	sext.w	a4,a4
	slli	a4,a4,32
	srli	a4,a4,32
	ld	a3,-104(s0)
	add	a4,a3,a4
	sb	a5,0(a4)
.L45:
	lw	a5,-28(s0)
	addiw	a5,a5,-1
	sw	a5,-28(s0)
.L44:
	lw	a5,-28(s0)
	sext.w	a5,a5
	bge	a5,zero,.L48
	sb	zero,-18(s0)
	sb	zero,-17(s0)
	j	.L61
.L36:
	lbu	a5,-18(s0)
	andi	a5,a5,0xff
	beq	a5,zero,.L49
	ld	a5,-128(s0)
	addi	a4,a5,8
	sd	a4,-128(s0)
	ld	a5,0(a5)
	j	.L50
.L49:
	ld	a5,-128(s0)
	addi	a4,a5,8
	sd	a4,-128(s0)
	lw	a5,0(a5)
.L50:
	sd	a5,-40(s0)
	ld	a5,-40(s0)
	bge	a5,zero,.L51
	ld	a5,-40(s0)
	neg	a5,a5
	sd	a5,-40(s0)
	lw	a5,-24(s0)
	addiw	a5,a5,1
	sw	a5,-24(s0)
	lw	a4,-24(s0)
	lw	a5,-108(s0)
	sext.w	a4,a4
	sext.w	a5,a5
	bgeu	a4,a5,.L51
	lw	a5,-24(s0)
	addiw	a5,a5,-1
	sext.w	a5,a5
	slli	a5,a5,32
	srli	a5,a5,32
	ld	a4,-104(s0)
	add	a5,a4,a5
	li	a4,45
	sb	a4,0(a5)
.L51:
	li	a5,1
	sd	a5,-48(s0)
	ld	a5,-40(s0)
	sd	a5,-56(s0)
	j	.L52
.L53:
	ld	a5,-48(s0)
	addi	a5,a5,1
	sd	a5,-48(s0)
.L52:
	ld	a4,-56(s0)
	li	a5,10
	div	a5,a4,a5
	sd	a5,-56(s0)
	ld	a5,-56(s0)
	bne	a5,zero,.L53
	ld	a5,-48(s0)
	sext.w	a5,a5
	addiw	a5,a5,-1
	sext.w	a5,a5
	sw	a5,-60(s0)
	j	.L54
.L56:
	lw	a5,-60(s0)
	lw	a4,-24(s0)
	addw	a5,a4,a5
	sext.w	a5,a5
	addiw	a5,a5,1
	sext.w	a4,a5
	lw	a5,-108(s0)
	sext.w	a5,a5
	bleu	a5,a4,.L55
	ld	a4,-40(s0)
	li	a5,10
	rem	a5,a4,a5
	andi	a4,a5,0xff
	lw	a5,-60(s0)
	lw	a3,-24(s0)
	addw	a5,a3,a5
	sext.w	a5,a5
	slli	a5,a5,32
	srli	a5,a5,32
	ld	a3,-104(s0)
	add	a5,a3,a5
	addiw	a4,a4,48
	andi	a4,a4,0xff
	sb	a4,0(a5)
.L55:
	ld	a4,-40(s0)
	li	a5,10
	div	a5,a4,a5
	sd	a5,-40(s0)
	lw	a5,-60(s0)
	addiw	a5,a5,-1
	sw	a5,-60(s0)
.L54:
	lw	a5,-60(s0)
	sext.w	a5,a5
	bge	a5,zero,.L56
	ld	a5,-48(s0)
	sext.w	a5,a5
	lw	a4,-24(s0)
	addw	a5,a4,a5
	sw	a5,-24(s0)
	sb	zero,-18(s0)
	sb	zero,-17(s0)
	j	.L61
.L33:
	ld	a5,-128(s0)
	addi	a4,a5,8
	sd	a4,-128(s0)
	ld	a5,0(a5)
	sd	a5,-72(s0)
	j	.L57
.L59:
	lw	a5,-24(s0)
	addiw	a5,a5,1
	sw	a5,-24(s0)
	lw	a4,-24(s0)
	lw	a5,-108(s0)
	sext.w	a4,a4
	sext.w	a5,a5
	bgeu	a4,a5,.L58
	lw	a5,-24(s0)
	addiw	a5,a5,-1
	sext.w	a5,a5
	slli	a5,a5,32
	srli	a5,a5,32
	ld	a4,-104(s0)
	add	a5,a4,a5
	ld	a4,-72(s0)
	lbu	a4,0(a4)
	sb	a4,0(a5)
.L58:
	ld	a5,-72(s0)
	addi	a5,a5,1
	sd	a5,-72(s0)
.L57:
	ld	a5,-72(s0)
	lbu	a5,0(a5)
	bne	a5,zero,.L59
	sb	zero,-18(s0)
	sb	zero,-17(s0)
	j	.L61
.L37:
	lw	a5,-24(s0)
	addiw	a5,a5,1
	sw	a5,-24(s0)
	lw	a4,-24(s0)
	lw	a5,-108(s0)
	sext.w	a4,a4
	sext.w	a5,a5
	bgeu	a4,a5,.L60
	ld	a5,-128(s0)
	addi	a4,a5,8
	sd	a4,-128(s0)
	lw	a3,0(a5)
	lw	a5,-24(s0)
	addiw	a5,a5,-1
	sext.w	a5,a5
	slli	a5,a5,32
	srli	a5,a5,32
	ld	a4,-104(s0)
	add	a5,a4,a5
	andi	a4,a3,0xff
	sb	a4,0(a5)
.L60:
	sb	zero,-18(s0)
	sb	zero,-17(s0)
	j	.L61
.L29:
	ld	a5,-120(s0)
	lbu	a5,0(a5)
	mv	a4,a5
	li	a5,37
	bne	a4,a5,.L62
	li	a5,1
	sb	a5,-17(s0)
	j	.L61
.L62:
	lw	a5,-24(s0)
	addiw	a5,a5,1
	sw	a5,-24(s0)
	lw	a4,-24(s0)
	lw	a5,-108(s0)
	sext.w	a4,a4
	sext.w	a5,a5
	bgeu	a4,a5,.L61
	lw	a5,-24(s0)
	addiw	a5,a5,-1
	sext.w	a5,a5
	slli	a5,a5,32
	srli	a5,a5,32
	ld	a4,-104(s0)
	add	a5,a4,a5
	ld	a4,-120(s0)
	lbu	a4,0(a4)
	sb	a4,0(a5)
	j	.L61
.L67:
	nop
.L61:
	ld	a5,-120(s0)
	addi	a5,a5,1
	sd	a5,-120(s0)
.L28:
	ld	a5,-120(s0)
	lbu	a5,0(a5)
	bne	a5,zero,.L63
	lw	a4,-24(s0)
	lw	a5,-108(s0)
	sext.w	a4,a4
	sext.w	a5,a5
	bgeu	a4,a5,.L64
	lwu	a5,-24(s0)
	ld	a4,-104(s0)
	add	a5,a4,a5
	sb	zero,0(a5)
	j	.L65
.L64:
	lw	a5,-108(s0)
	sext.w	a5,a5
	beq	a5,zero,.L65
	lw	a5,-108(s0)
	addiw	a5,a5,-1
	sext.w	a5,a5
	slli	a5,a5,32
	srli	a5,a5,32
	ld	a4,-104(s0)
	add	a5,a4,a5
	sb	zero,0(a5)
.L65:
	lw	a5,-24(s0)
	mv	a0,a5
	ld	s0,120(sp)
	addi	sp,sp,128
	jr	ra
	.size	vsnprintf, .-vsnprintf
	.align	1
	.globl	snprintf
	.type	snprintf, @function
snprintf:
	addi	sp,sp,-112
	sd	ra,56(sp)
	sd	s0,48(sp)
	addi	s0,sp,64
	sd	a0,-40(s0)
	sd	a2,-56(s0)
	sd	a3,8(s0)
	sd	a4,16(s0)
	sd	a5,24(s0)
	sd	a6,32(s0)
	sd	a7,40(s0)
	mv	a5,a1
	sw	a5,-44(s0)
	addi	a5,s0,48
	sd	a5,-64(s0)
	ld	a5,-64(s0)
	addi	a5,a5,-40
	sd	a5,-32(s0)
	ld	a4,-32(s0)
	lw	a5,-44(s0)
	mv	a3,a4
	ld	a2,-56(s0)
	mv	a1,a5
	ld	a0,-40(s0)
	call	vsnprintf
	mv	a5,a0
	sw	a5,-20(s0)
	lw	a5,-20(s0)
	mv	a0,a5
	ld	ra,56(sp)
	ld	s0,48(sp)
	addi	sp,sp,112
	jr	ra
	.size	snprintf, .-snprintf
	.ident	"GCC: (GNU) 9.2.0"
