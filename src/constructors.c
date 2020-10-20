// see LICENSE for licensing details
#include "constructors.h"


    // defined by linker, first global constructor
    extern void (*__CTORS_START)(void);
    // defined by linker, last global constructor
    extern void (*__CTORS_END)(void);

    extern char _fbss;
    extern char _ebss;

    void run_constructors(void) {
        // Zero out the bss segment
        // for (volatile char *p = &_fbss; p != &_ebss; p++) { *p = '\0'; }

        // // calls all constructors between __CTORS_START and __CTORS_END
        // // needs to be aligned by on 8 Byte boundary
        // for( void (** volatile ctor)() = &__CTORS_START; ctor != &__CTORS_END; ++ctor ) {
        //     (*ctor)();
        // }
    }
