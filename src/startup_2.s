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
	.section	.rodata
	.align	3
.LC0:
	.string	"ocaml-boot: heap@0x%x stack@0x%x\n"
	.align	3
.LC1:
	.string	"ocaml-boot: caml runtime returned. shutting down!\n"
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
	lui	a5,%hi(__KERNEL_END)
	addi	a5,a5,%lo(__KERNEL_END)
	sd	a5,-48(s0)
	lui	a5,%hi(stack_size)
	ld	a4,%lo(stack_size)(a5)
	lui	a5,%hi(stack)
	addi	a5,a5,%lo(stack)
	add	a5,a4,a5
	mv	a2,a5
	ld	a1,-48(s0)
	lui	a5,%hi(.LC0)
	addi	a0,a5,%lo(.LC0)
	call	printf
	lui	a5,%hi(mem_size)
	ld	a5,%lo(mem_size)(a5)
	mv	a1,a5
	ld	a0,-48(s0)
	call	riscv_boot_finished
	lui	a5,%hi(.LC1)
	addi	a0,a5,%lo(.LC1)
	call	printf
	call	htif_poweroff
	.size	boot_primary, .-boot_primary
	.section	.rodata
	.align	3
.LC2:
	.string	"startup_2.c"
	.align	3
.LC3:
	.string	"false && \"multicore systems are not supported\""
	.align	3
.LC4:
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
	lui	a5,%hi(.LC2)
	addi	a2,a5,%lo(.LC2)
	lui	a5,%hi(.LC3)
	addi	a1,a5,%lo(.LC3)
	lui	a5,%hi(.LC4)
	addi	a0,a5,%lo(.LC4)
	call	printf
.L3:
	j	.L3
	.size	boot_secondary, .-boot_secondary
	.ident	"GCC: (GNU) 9.2.0"
