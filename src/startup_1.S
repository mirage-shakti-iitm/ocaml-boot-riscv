#include "defs.h"
#include "encoding.h"

# uint64_t
# __attribute__((section (".pc-bounds-reserved") ))
# __attribute__(( aligned (16) ))
# pc_base_array[256] = {0};

# void initialize_pc_bounds (void) __attribute__ ((section (".text.init")));

# Tail-Calls optimization
# C1 -> C2 -> C4 tail call allowed

# C1 -> C2 -> C254 allow return from 254, even if allow_cross_comp = 0, 

# C254 -> C2 -> C1

# C1 -> C1 -> C3

.option norvc
.section .text.init,"ax",@progbits
.globl reset_vector
reset_vector:
   j do_reset

.global do_reset;
.global trap_handler
.global initialize_pc_bounds;

# .global run_constructors

do_reset:
        
        li x1, 0
        li x2, 0
        li x3, 0
        li x4, 0
        li x5, 0
        li x6, 0
        li x7, 0
        li x8, 0
        li x9, 0
        li x10, 0
        li x11, 0
        li x12, 0
        li x13, 0
        li x14, 0
        li x15, 0
        li x16, 0
        li x17, 0
        li x18, 0
        li x19, 0
        li x20, 0
        li x21, 0
        li x22, 0
        li x23, 0
        li x24, 0
        li x25, 0
        li x26, 0
        li x27, 0
        li x28, 0
        li x29, 0
        li x30, 0
        li x31, 0
        csrw mscratch, x0


        # write mtvec and make sure it sticks
        la t0, trap_vector
        csrw mtvec, t0
        csrr t1, mtvec
1:      bne t0, t1, 1b

        // stacks grow backwards, set correct tos for hart 0
        la sp, stack + STACK_SIZE

        # Enable Capability control
        li t0, ENABLE_CAP # ENABLE_CAP is 0x1 for now
        csrw 0xb03, 0x0   ## MHPMCOUNTER_3
        csrw 0x323, 0x1f  ## MHPMEVENT_3 - Number of cross compartment exceptions
        csrw 0xb04, 0x0   ## MHPMCOUNTER_4
        li t6, 0x20
        csrw 0x324, t6    ## MHPMEVENT_4 - Number of cycles spent in cross compartment ISR
        csrw 0xb05, 0x0   ## MHPMCOUNTER_5
        li t6, 0x21
        csrw 0x325, t6  ## MHPMEVENT_5 - Number of cycles spent in hash instructions
        csrw 0xb06, 0x0   ## MHPMCOUNTER_6
        li t6, 0x22
        csrw 0x326, t6    ## MHPMEVENT_6 - Number of cycles spent in val instructions
        csrw mcapctl, t0

        # li x1, 0
        # li x2, 0
        # li x3, 0
        # li x4, 0
        li x5, 0
        li x6, 0
        li x7, 0
        # li x8, 0
        # li x9, 0
        # li x10, 0
        # li x11, 0
        # li x12, 0
        # li x13, 0
        # li x14, 0
        # li x15, 0
        # li x16, 0
        # li x17, 0
        # li x18, 0
        # li x19, 0
        # li x20, 0
        # li x21, 0
        # li x22, 0
        # li x23, 0
        # li x24, 0
        # li x25, 0
        # li x26, 0
        # li x27, 0
        li x28, 0
        li x29, 0
        li x30, 0
        li x31, 0

        // boot process is different for each hart
        csrr a3, mhartid

        // jump into arch_startup on hart 0
        beqz a3, 2f

        // otherwise jump to arch_startup_secondary
        j boot_secondary
2:
        // run constructors on hart 0
        # jal run_constructors
        // and then call c-land
        
        j boot_primary
.size do_reset, . - do_reset


.global trap_vector
trap_vector:
    
    # HWR Begin
    csrr t2, mcause
    
    csrw mcapctl, x0 # Disable Capability checks
    # HWR End

    csrw mscratch, sp
    addi sp, sp, -32*8

    # mepc is saved later
    sd ra, 1*8(sp)
    sd gp, 3*8(sp)
    sd tp, 4*8(sp)
    sd t0, 5*8(sp)
    sd t1, 6*8(sp)
    sd t2, 7*8(sp)
    sd s0, 8*8(sp)
    sd s1, 9*8(sp)
    sd a0, 10*8(sp)
    sd a1, 11*8(sp)
    sd a2, 12*8(sp)
    sd a3, 13*8(sp)
    sd a4, 14*8(sp)
    sd a5, 15*8(sp)
    sd a6, 16*8(sp)
    sd a7, 17*8(sp)
    sd s2, 18*8(sp)
    sd s3, 19*8(sp)
    sd s4, 20*8(sp)
    sd s5, 21*8(sp)
    sd s6, 22*8(sp)
    sd s7, 23*8(sp)
    sd s8, 24*8(sp)
    sd s9, 25*8(sp)
    sd s10, 26*8(sp)
    sd s11, 27*8(sp)
    sd t3,  28*8(sp)
    sd t4,  29*8(sp)
    sd t5,  30*8(sp)
    sd t6,  31*8(sp)

    # Store the exception return address
    csrr a0, mepc
    sd a0,  0*8(sp)

    # Arguments for our interrupt handler
    csrr a1, mscratch         # ra <- user sp
    sd a1, 2*8(sp)            # store user sp on stack
    csrr a0, mcause
    mv a1, sp
    
    jal trap_handler

    # Restore exception pointer
    ld a0, 0*8(sp)
    csrw mepc, a0

    ld ra, 1*8(sp)
    # sp is restored at end
    ld gp, 3*8(sp)
    ld tp, 4*8(sp)
    ld t0, 5*8(sp)
    ld t1, 6*8(sp)
    ld t2, 7*8(sp)
    ld s0, 8*8(sp)
    ld s1, 9*8(sp)
    ld a0, 10*8(sp)
    ld a1, 11*8(sp)
    ld a2, 12*8(sp)
    ld a3, 13*8(sp)
    ld a4, 14*8(sp)
    ld a5, 15*8(sp)
    ld a6, 16*8(sp)
    ld a7, 17*8(sp)
    ld s2, 18*8(sp)
    ld s3, 19*8(sp)
    ld s4, 20*8(sp)
    ld s5, 21*8(sp)
    ld s6, 22*8(sp)
    ld s7, 23*8(sp)
    ld s8, 24*8(sp)
    ld s9, 25*8(sp)
    ld s10, 26*8(sp)
    ld s11, 27*8(sp)
    ld t3,  28*8(sp)
    ld t4,  29*8(sp)
    ld t5,  30*8(sp)
    ld t6,  31*8(sp)

    ld sp, 2*8(sp) # restore user sp
    mret

.size trap_vector, . - trap_vector

