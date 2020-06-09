	.file	"startup_2.c"
	.option nopic
	.attribute arch, "rv64i2p0_m2p0_a2p0_f2p0_d2p0_c2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.globl	stack
	.data
	.align	4
	.type	stack, @object
	.size	stack, 4096
stack:
	.string	"\336\255\276\357"
	.zero	4091
	.text
	.align	1
	.globl	boot_primary
	.type	boot_primary, @function
boot_primary:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	addi	s0,sp,48
 #APP
# 18 "startup_2.c" 1
	csrr a5, mstatus
# 0 "" 2
 #NO_APP
	sd	a5,-24(s0)
	ld	a5,-24(s0)
	sd	a5,-32(s0)
	ld	a4,-32(s0)
	li	a5,24576
	or	a5,a4,a5
	sd	a5,-32(s0)
	ld	a5,-32(s0)
	ori	a5,a5,8
	sd	a5,-32(s0)
	ld	a5,-32(s0)
 #APP
# 21 "startup_2.c" 1
	csrw mstatus, a5
# 0 "" 2
# 22 "startup_2.c" 1
	csrrs a5, mie, 7
# 0 "" 2
 #NO_APP
	sd	a5,-40(s0)
	lla	a5,__KERNEL_END
	sd	a5,-48(s0)
	call	htif_poweroff
	.size	boot_primary, .-boot_primary
	.section	.rodata
	.align	3
.LC0:
	.string	"startup_2.c"
	.align	3
.LC1:
	.string	"false && \"multicore systems are not supported\""
	.align	3
.LC2:
	.string	"Assertion '%s' failed in file/line %s:%s\n"
	.text
	.align	1
	.globl	boot_secondary
	.type	boot_secondary, @function
boot_secondary:
	addi	sp,sp,-16
	sd	ra,8(sp)
	sd	s0,0(sp)
	addi	s0,sp,16
	li	a3,48
	lla	a2,.LC0
	lla	a1,.LC1
	lla	a0,.LC2
	call	printf
.L3:
	j	.L3
	.size	boot_secondary, .-boot_secondary
	.ident	"GCC: (GNU) 9.2.0"
