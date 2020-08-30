#include "defs.h"
#include "encoding.h"


.option norvc
.section .text.init,"ax",@progbits
.globl reset_vector
reset_vector:
   j do_reset

.global do_reset;
# .global run_constructors
do_reset:
        # Enable Capability control
        li t0, ENABLE_CAP # ENABLE_CAP is 0x1 for now
        # Initial compartment i.e. starting compartment
        li t1, INITIAL_COMPARTMENT
        # Load cap_matrix_base 
        la t2, cap_matrix
        # Load checkcap_sp to save/restore registers etc...
        la t3, checkcap_stack + CHECKCAP_STACK_SIZE
        # Disable no_cross_comp initially. Always fist compartment should not be 255/254
        li t4, 0x0
        # Load checkcap_isr base
        la t5, CHECKCAP_EXCEPTION

        # set corresponding CSRs
        csrw mcapctl, t0
        csrw ucurrcap, t1
        csrw mcapmatrixbase, t2
        csrw mcheckcapsp, t3
        csrw unocrosscomp, t4
        # set utailcall to 0 initially
        csrw utailcall, t4
        csrw mcrosscompexception, t5

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

.global trap_handler
.global trap_vector
trap_vector:
    csrw mcapctl, x0 # Disable Capability checks
    
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

.global print_checkcap_cross_comp_matrix_fail
.global print_checkcap_no_cross_comp_fail

CHECKCAP_EXCEPTION:
	#Find out the exact cause of checkcap exception
	csrr t0, utargetcap
    csrr t1, unocrosscomp
    csrr t2, ucurrcap
    li t3, 254

    beq t0, t3, CHECKCAP_254

    beq t0, t2, CHECKCAP_NON_254
    
    li t4, 1
    beq t1, t4, CHECKCAP_NO_CROSS_COMP_FAIL

    j CHECKCAP_CROSS_COMP


CHECKCAP_254:
    #Step 1: Check if it is a tail-call, if yes skip saving the return registers on the checkcap-stack and changing the return-address
    la t0, CHECKCAP_254_RETURN
    beq ra, t0, COMMON_254
    la t0, CHECKCAP_NON_254_RETURN
    beq ra, t0, COMMON_254
    la t0, CHECKCAP_CROSS_COMP_RETURN
    beq ra, t0, COMMON_254
    
    #Step 2: Read CSR_MCHECKCAPSP
    csrr t2, mcheckcapsp

    #Step 3: Storing ra register

    addi t2, t2, -1*8
    sd ra, 0*8(t2)

    # update CSR_MCHECKCAPSP
    csrw mcheckcapsp, t2

    #Step 4: setting the ra to point to CHECKCAP_254_RETURN
    la ra, CHECKCAP_254_RETURN

COMMON_254:
    #Step 5: Enabling the CSR_UNOCROSSCOMP
    li t2, 0x1
    csrw unocrosscomp, t2

    #Step 6: Zero out the register t2
    li t0, 0
    li t1, 0
    li t2, 0
    li t3, 0
    li t4, 0
    li t5, 0
    li t6, 0

    #Step 7: Call target function again
    mret
    
CHECKCAP_254_RETURN:
    #Step 1: Read CSR_MCHECKCAPSP
    csrr t2, mcheckcapsp

    #Step 2: Popping the registers first itself
    ld ra, 0*8(t2)

    # update CSR_MCHECKCAPSP
    addi t2, t2, 1*8
    csrw mcheckcapsp, t2

    # Step 3: Zero out the register t2
    li t0, 0
    li t1, 0
    li t2, 0
    li t3, 0
    li t4, 0
    li t5, 0
    li t6, 0

    #Step 4: Disabling the CSR_UNOCROSSCOMP
    csrw unocrosscomp, t2

    #Step 5: Return to caller function
    jr ra

CHECKCAP_NON_254:
    #Step 2: Check if it is a tail-call, if yes skip saving the return registers on the checkcap-stack and changing the return-address
    la t0, CHECKCAP_254_RETURN
    beq ra, t0, COMMON_NON_254
    la t0, CHECKCAP_NON_254_RETURN
    beq ra, t0, COMMON_NON_254
    la t0, CHECKCAP_CROSS_COMP_RETURN
    beq ra, t0, COMMON_NON_254

    #Step 2: Read CSR_MCHECKCAPSP
    csrr t2, mcheckcapsp

    #Step 3: Storing ra register
    addi t2, t2, -1*8
    sd ra, 0*8(t2)

    # update CSR_MCHECKCAPSP
    csrw mcheckcapsp, t2

    #Step 4: setting the ra to point to CHECKCAP_254_RETURN
    la ra, CHECKCAP_NON_254_RETURN

COMMON_NON_254:    
    # Step 5: Zero out the register t2
    li t0, 0
    li t1, 0
    li t2, 0
    li t3, 0
    li t4, 0
    li t5, 0
    li t6, 0

    #Step 6: Disabling the CSR_UNOCROSSCOMP
    csrw unocrosscomp, t2

    #Step 7: Call target function again
    mret

CHECKCAP_NON_254_RETURN:
    #Step 1: Read CSR_MCHECKCAPSP
    csrr t2, mcheckcapsp

    #Step 2: Popping the registers first itself
    ld ra, 0*8(t2)

    # update CSR_MCHECKCAPSP
    addi t2, t2, 1*8
    csrw mcheckcapsp, t2

    #Step 3: Enabling the CSR_UNOCROSSCOMP
    li t2, 1
    csrw unocrosscomp, t2

    # Step 4: Zero out the register t2
    li t0, 0
    li t1, 0
    li t2, 0
    li t3, 0
    li t4, 0
    li t5, 0
    li t6, 0

    #Step 5: Return to caller function
    jr ra
    

CHECKCAP_CROSS_COMP:
    #Step 1: Check if it is a tail-call, if yes skip saving the return registers on the checkcap-stack and changing the return-address
    # la t0, CHECKCAP_254_RETURN
    # beq ra, t0, COMMON_CROSS_COMP
    # la t0, CHECKCAP_NON_254_RETURN
    # beq ra, t0, COMMON_CROSS_COMP
    la t0, CHECKCAP_CROSS_COMP_RETURN
    beq ra, t0, COMMON_CROSS_COMP

    #Step 2: Read CSR_MCHECKCAPSP
    csrr t2, mcheckcapsp

    #Step 3: Storing curr_cap, ra, sp, gp, tp register

    addi t2, t2, -5*8

    # actual t0 stored in mscratch is saved later (neglect this comment for now, because no need to save/restore temporary registers as they are caller-saved)
    sd ra, 1*8(t2)
    sd sp, 2*8(t2)
    sd gp, 3*8(t2)
    sd tp, 4*8(t2)

    csrr t3, ucurrcap

    #store CURRCAP
    sd t3, 0*8(t2)

    # update CSR_MCHECKCAPSP
    csrw mcheckcapsp, t2

    #Step 4: setting the ra to point to CHECKCAP_CROSS_COMP_RETURN
    la ra, CHECKCAP_CROSS_COMP_RETURN

    ##### Not doing this check for now
    #Step 5: Checking whether CSR_MCHECKCAPSP is within CSR_MCHECKCAPSPBASE and CSR_MCHECKCAPSPBOUND
    # (lower addr) Bound ---- SP ---- (higher addr) Base
    # csrr t1, mcheckcapspbase
    # csrr t2, mcheckcapspbound
    # blt t0, t1, Checkcap_SP_Out_Of_Bound
    # blt t1, t2, Checkcap_SP_Out_Of_Bound

COMMON_CROSS_COMP:
    #Step 6: Checking for cross-compartment Capability condition
    # ucurrcap
    # utargetcap
    # mcapmatrixbase
    ## access capability matrix. 
    # Here I am assuming that the capability matrix base address is stored in CSR_BASE_CAP_MATRIX
    csrr t0, mcapmatrixbase
    # Current Capability and Target Capability stored in CSRs CSR_UCURRCAP and CSR_UTARGETCAP respectively
    csrr t1, ucurrcap
    csrr t2, utargetcap
    # Assuming that the Capability matrix is stored as an array, where each compartment has its corresponding capability information in 256 bit entry.
    # Assuming each word is 64 bits, so the word that contains the target_cap info w.r.t curr_cap has to be loaded.
    # Accessing the capability matrix for a given curr_cap and target_cap is as follows:
    # SubStep 1: Finding the index(t3) corresponding to the target_cap and curr_cap: 
    # t3 = (t5)5*curr_cap + (t3){either of 0,1,2 or 3, depending on which group the target_cap lies, whether in 0-63, 64-127, 128-191, 192-255}*8(why 8 because
    # byte addressable). 
    addi t3, x0, 0 
    addi t4, x0, 0x40
    bltu t2, t4, Found_index
    addi t3, t3, 1
    addi t4, t4, 0x40
    bltu t2, t4, Found_index
    addi t3, t3, 1
    addi t4, t4, 0x40
    bltu t2, t4, Found_index
    addi t3, t3, 1
    addi t4, t4, 0x40
Found_index:
    sll t5, t1, 0x5 # t5= curr_cap * 32
    sll t3, t3, 0x3 # t3= word_offset wrt curr cap entry in table * 8
    add t5, t5, t3  # word offset wrt to start of table
    add t0, t0, t5  # word offset + base address of cap matrix
    ld t3, 0(t0)    # 64-bit entry of corresponding cap matrix
    # Getting the bit corresponding to the target_cap from the loaded word based on generating an appropriate mask w.r.t target_cap and &ing with the
    # loaded word  
    sub t4, t4, t2 # {256, 192, 128, 64} - target_cap. t4= {1-64}
    addi t4, t4, -0x1 # t4= {0-63} 
    # setting the MSB as 1 and rest 0's
    addi t5, x0, 0x1
    # setting bit w.r.t target_cap 1 and rest 0's
    slli t5, t5, 0x3f
    srl t5, t5, t4
    # anding t3 and t5(mask). If the output is 0 then check fail else, pass
    and t3, t3, t5
    beqz t3, CAPABILITY_CHECK_FAIL

    #Step 7: Change current_cap to target_cap
    csrw ucurrcap, t2

    #Step 8: zeroing out non-argument/return value registers. Not zeroing out sp, tp, gp, fp
    li t0, 0
    li t1, 0
    li t2, 0
    li t3, 0
    li t4, 0
    li t5, 0
    li t6, 0

    #Step 9: Call target function again
    mret

CHECKCAP_CROSS_COMP_RETURN:
    #Step 1: Read CSR_MCHECKCAPSP
    csrr t2, mcheckcapsp

    #Step 2: Popping the registers first itself

    # actual t0, t1 restored later (neglect this comment for now, because no need to save/restore temporary registers as they are caller-saved)
    ld ra, 1*8(t2)
    ld sp, 2*8(t2)
    ld gp, 3*8(t2)
    ld tp, 4*8(t2)
    
    # restore CSR_UCURRCAP
    ld t1, 0*8(t2)
    csrw ucurrcap, t1

    # update CSR_MCHECKCAPSP
    addi t2, t2, 5*8
    csrw mcheckcapsp, t2

    # Step 3: Zero out the t0-t6 registers 
    li t0, 0
    li t1, 0
    li t2, 0
    li t3, 0
    li t4, 0
    li t5, 0
    li t6, 0

    #Step 4: Disabling the CSR_UNOCROSSCOMP. This is done, 
    csrw unocrosscomp, t2

    #Step 5: Return to caller function
    jr ra


CAPABILITY_CHECK_FAIL:
    # If we follow the idea where we store the registers before the actual checking is done, then we need to remove them before we exit. And next, what 
    # should we do, poweroff!! ?
    csrw mcapctl, x0 # Disable Capability checks
    j print_checkcap_cross_comp_matrix_fail

CHECKCAP_NO_CROSS_COMP_FAIL:
    # Cross-Compartment jump attempted when CSR_UNOCROSSCOMP bit set
    csrw mcapctl, x0 # Disable Capability checks
    j print_checkcap_no_cross_comp_fail


