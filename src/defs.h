#define STACK_SIZE 65536
#define STACK_SHIFT 16

// Compartment specific macros that should be set on entry.
#define CHECKCAP_STACK_SIZE 4096*2
#define ENABLE_CAP 0x0
#define INITIAL_COMPARTMENT 0x0
#define Total_Compartments 256
#define Fully_Trusted_Compartment 255
#define Restricted_Compartment 254
#define Reserved_Compartment 0