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
#1:      bne t0, t1, 1b

        // stacks grow backwards, set correct tos for hart 0
        la sp, stack + STACK_SIZE
        la t1, initialize_pc_bounds
        # Initialize PC Base and Bounds.( sets 2.5 sets of PC base and bound)
        jalr t1 

        # Initialize setu_return_compartment_handler_pc
        la t0, setu_return_compartment_handler_pc
        la t1, CHECKCAP_CROSS_COMP_RETURN
        sd t1, 0(t0)

        # Enable Capability control
        li t0, ENABLE_CAP # ENABLE_CAP is 0x1 for now
        # Initial compartment i.e. starting compartment
        li t1, INITIAL_COMPARTMENT
        # Load cap_matrix_base 
        la t2, cap_matrix
        # Load checkcap_sp to save/restore registers etc...
        la t3, checkcap_stack + CHECKCAP_STACK_SIZE
        # Load pc base and bound array
        la t4, pc_base_bound_array
        # load cross-comp entry ISR PC value
        la t5, CHECKCAP_CROSS_COMP
        # load cross-comp return ISR PC value
        la t6, CHECKCAP_CROSS_COMP_RETURN_ISR
        # set corresponding CSRs
        csrw ucurrcap, t1
        csrw mcapmatrixbase, t2
        csrw ucheckcapsp, t3
        csrw mcappcbaseboundbase, t4
        csrw mcrosscompexception, t5
        csrw mcrosscompretexception, t6
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
        # j boot_secondary
2:
        // run constructors on hart 0
        # jal run_constructors
        // and then call c-land
        la x5, boot_primary
        jr x5
.size do_reset, . - do_reset

# .section .text.trap_vector,"ax",@progbits
.global trap_vector
trap_vector:
    # HWR Begin
    csrr t2, mcause
    li t3, CAUSE_TEE_PC_OUT_OF_BOUNDS_EXCEPTION
    beq t3, t2, CHECKCAP_NO_CROSS_COMP_FAIL

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
    
    la t1, trap_handler
    jalr t1

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

.global print_checkcap_cap_matrix_fail
.global print_checkcap_no_cross_comp_fail

CHECKCAP_CROSS_COMP:
    
    #Step 0: Saving t2
    # csrw mscratch, t2


    #Step 1: Check if it is a tail-call, if yes skip saving the return registers on the checkcap-stack and changing the return-address
    la t2, CHECKCAP_CROSS_COMP_RETURN
    beq ra, t2, COMMON_CROSS_COMP

    #Step 2: Read CSR_UCHECKCAPSP
    csrr t2, ucheckcapsp

    #Step 3: Storing curr_cap, ra, sp, gp, tp register

    addi t2, t2, -7*8

    # actual t0 stored in mscratch is saved later (neglect this comment for now, because no need to save/restore temporary registers as they are caller-saved)
    # mepc is saved later
    sd ra, 1*8(t2)
    sd sp, 2*8(t2)
    sd gp, 3*8(t2)
    sd tp, 4*8(t2)
    # sd s0, 5*8(t2)
    # sd s1, 6*8(t2)
    # sd s2, 7*8(t2)
    # sd s3, 8*8(t2)
    # sd s4, 9*8(t2)
    # sd s5, 10*8(t2)
    # sd s6, 11*8(t2)
    # sd s7, 12*8(t2)
    # sd s8, 13*8(t2)
    # sd s9, 14*8(t2)
    # sd s10,5*8(t2)
    # sd s11,15*8(t2)

    csrr t3, ucurrcappcbase
    #store CURRCAPPCBASE
    sd t3, 5*8(t2)

    csrr t3, ucurrcappcbound
    #store CURRCAPPCBOUND
    sd t3, 6*8(t2)

    csrr t3, ucurrcap
    #store CURRCAP
    sd t3, 0*8(t2)

    # update CSR_UCHECKCAPSP
    csrw ucheckcapsp, t2

    # Pushing actual ra to separate stack for ocaml root scanning
OCAML_CURRENT_COMPARTMENT_CHECK:
    csrr t1, ucurrcap
    sll t1, t1, 0x3
    la t0, ocaml_pc_end
    add t0, t1, t0
    ld t1, 0(t0)
    bgeu t1, ra, IN_OCAML
OCAML_255_CHECK:
#   Removing the lower bound check since cross-compartment calls can only take place from 255 and not 254. 
#   csrr t1, uanycappcbase
    addi t1, x0, 0xff
    sll t1, t1, 0x3
    la t0, ocaml_pc_end
    add t0, t1, t0
    ld t1, 0(t0)
    bltu t1, ra, NOT_OCAML
IN_OCAML:
    la t0, ocaml_gc_cross_compartment_stack_position
    ld t2, 0(t0)
    addi t3, t2, 1
    sd t3, 0(t0)
    la t1, ocaml_gc_cross_compartment_stack
    sll t2, t2, 0x3 
    add t1, t1, t2
    sd ra, 0(t1)


NOT_OCAML:
    #Step 4: setting the ra to point to CHECKCAP_CROSS_COMP_RETURN
    la ra, CHECKCAP_CROSS_COMP_RETURN



    ##### Not doing this check for now
    #Step 5: Checking whether CSR_UCHECKCAPSP is within CSR_MCHECKCAPSPBASE and CSR_MCHECKCAPSPBOUND
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
    # beqz t3, CAPABILITY_CHECK_FAIL

    #Step 7: Change current_cap to target_cap
    csrw ucurrcap, t2

    #Step 8: Change CSR_UCURRCAP_PCBASE and CSR_UCURRCAP_PCBOUND
    csrr t3, mcappcbaseboundbase
    # pc_base index
    sll t5, t2, 0x1
    sll t5, t5, 0x3
    add t3, t3, t5
    # loading pc_base
    ld t4, 0(t3)
    # pc_bound index
    addi t3, t3, 0x8
    # loading pc_bound
    ld t5, 0(t3)
    # setting the CSRs
    csrw ucurrcappcbase, t4
    csrw ucurrcappcbound, t5

    #Step 9: zeroing out non-argument/return value registers. Not zeroing out sp, tp, gp, fp
    li t0, 0
    li t1, 0
    li t2, 0
    li t3, 0
    li t4, 0
    li t5, 0
    li t6, 0

    #Step 10: Call target function again
    mret

CHECKCAP_CROSS_COMP_RETURN:

    #Step 0: Adding Checkcap instruction
    checkcap 0
    
CHECKCAP_CROSS_COMP_RETURN_ISR:
    #Step 1: Read CSR_UCHECKCAPSP
    csrr t2, ucheckcapsp

    #Step 2: Popping the registers first itself

    # actual t0, t1 restored later (neglect this comment for now, because no need to save/restore temporary registers as they are caller-saved)
    ld ra, 1*8(t2)
    ld sp, 2*8(t2)
    ld gp, 3*8(t2)
    ld tp, 4*8(t2)
    # ld s0, 5*8(t2)
    # ld s1, 6*8(t2)
    # ld s2, 7*8(t2)
    # ld s3, 8*8(t2)
    # ld s4, 9*8(t2)
    # ld s5, 10*8(t2)
    # ld s6, 11*8(t2)
    # ld s7, 12*8(t2)
    # ld s8, 13*8(t2)
    # ld s9, 14*8(t2)
    # ld s10,5*8(t2)
    # ld s11,15*8(t2)

    # restore CSR_UCURRCAP_PCBASE
    ld t1, 5*8(t2)
    csrw ucurrcappcbase, t1

    # restore CSR_UCURRCAP_PCBOUND
    ld t1, 6*8(t2)
    csrw ucurrcappcbound, t1
    
    # restore CSR_UCURRCAP
    ld t1, 0*8(t2)
    csrw ucurrcap, t1

    # update CSR_UCHECKCAPSP
    addi t2, t2, 7*8
    csrw ucheckcapsp, t2

    # Removing actual ra from separate stack if returning to ocaml land
OCAML_CURRENT_COMPARTMENT_CHECK_R:
    # csrr t1, ucurrcap
    sll t1, t1, 0x3
    la t0, ocaml_pc_end
    add t0, t1, t0
    ld t1, 0(t0)
    bgeu t1, ra, IN_OCAML_R
OCAML_255_CHECK_R:
#   Removing the lower bound check since cross-compartment calls can only take place from 255 and not 254. 
#   csrr t1, uanycappcbase
    addi t1, x0, 0xff
    sll t1, t1, 0x3
    la t0, ocaml_pc_end
    add t0, t1, t0
    ld t1, 0(t0)
    bltu t1, ra, NOT_OCAML_R
IN_OCAML_R:
    la t0, ocaml_gc_cross_compartment_stack_position
    ld t2, 0(t0)
    beq t2, x0, NOT_OCAML_R
    addi t2, t2, -1
    sd t2, 0(t0)
    la t1, ocaml_gc_cross_compartment_stack
    sll t2, t2, 0x3 
    add t1, t1, t2
    sd x0, 0(t1)

NOT_OCAML_R:
    # Step 3: Zero out the t0-t6 registers 
    li t0, 0
    li t1, 0
    li t2, 0
    li t3, 0
    li t4, 0
    li t5, 0
    li t6, 0

    #Step 4: Change ucompepc. Originally it was pointing to CHECKCAP_CROSS_COMP_RETURN
    csrw ucompepc, ra

    # Step 5: Return to ra(through mepc)
    mret


CAPABILITY_CHECK_FAIL:
    # If we follow the idea where we store the registers before the actual checking is done, then we need to remove them before we exit. And next, what 
    # should we do, poweroff!! ?

    # HWR Begin
    csrw mcapctl, x0 # Disable Capability checks
    # HWR End
    la t1, print_checkcap_cap_matrix_fail
    jr t1

CHECKCAP_NO_CROSS_COMP_FAIL:
    # Cross-Compartment jump attempted when CSR_UNOCROSSCOMP bit set

    # HWR Begin
    csrw mcapctl, x0 # Disable Capability checks
    # HWR End
    la t1, print_checkcap_no_cross_comp_fail
    jr t1
