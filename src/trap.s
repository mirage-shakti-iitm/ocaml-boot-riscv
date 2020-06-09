	.file	"trap.c"
	.option nopic
	.attribute arch, "rv64i2p0_m2p0_a2p0_f2p0_d2p0_c2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.section	.rodata
	.align	3
.LC0:
	.string	"ocaml boot: trap (%d) @ 0x%x mtval=0x%x\n"
	.align	3
.LC1:
	.string	"ocaml boot: irq (%d) @ 0x%x mtval=0x%x\n"
	.text
	.align	1
	.globl	trap_handler
	.type	trap_handler, @function
trap_handler:
	addi	sp,sp,-80
	sd	ra,72(sp)
	sd	s0,64(sp)
	addi	s0,sp,80
	sd	a0,-72(s0)
	sd	a1,-80(s0)
	ld	a5,-72(s0)
	beq	a5,zero,.L2
 #APP
# 10 "trap.c" 1
	csrr a5, mepc
# 0 "" 2
 #NO_APP
	sd	a5,-48(s0)
	ld	a4,-48(s0)
 #APP
# 10 "trap.c" 1
	csrr a5, mtval
# 0 "" 2
 #NO_APP
	sd	a5,-56(s0)
	ld	a5,-56(s0)
	mv	a3,a5
	mv	a2,a4
	ld	a1,-72(s0)
	lla	a0,.LC0
	call	printf
	j	.L3
.L2:
	lla	a5,mask.1573
	ld	a5,0(a5)
	ld	a4,-72(s0)
	and	a5,a4,a5
	sd	a5,-24(s0)
 #APP
# 16 "trap.c" 1
	csrr a5, mepc
# 0 "" 2
 #NO_APP
	sd	a5,-32(s0)
	ld	a4,-32(s0)
 #APP
# 16 "trap.c" 1
	csrr a5, mtval
# 0 "" 2
 #NO_APP
	sd	a5,-40(s0)
	ld	a5,-40(s0)
	mv	a3,a5
	mv	a2,a4
	ld	a1,-24(s0)
	lla	a0,.LC1
	call	printf
.L3:
	call	htif_poweroff
	.size	trap_handler, .-trap_handler
	.section	.sdata,"aw"
	.align	3
	.type	mask.1573, @object
	.size	mask.1573, 8
mask.1573:
	.dword	9223372036854775807
	.ident	"GCC: (GNU) 9.2.0"
