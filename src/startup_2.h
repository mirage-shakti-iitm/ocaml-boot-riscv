#ifndef startup_h
#define startup_h

// provided by linker
extern char __KERNEL_END;


//provided by libasmrun.a
extern void caml_startup(const char** argv);

//provided by libnolibc.a
extern void _nolibc_init(uintptr_t heap_start, uint64_t heap_size);

// provided by application
extern void main();


#endif
