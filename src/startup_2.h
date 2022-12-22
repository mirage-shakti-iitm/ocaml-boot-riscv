#ifndef startup_h
#define startup_h

// provided by linker
extern char __KERNEL_END;
extern char _srodata;
extern char _erodata;
extern char edata;
extern char start_sdata;
extern char end_sdata;
extern char start_uninitialized_data;
extern char end_uninitialized_data;
extern char start_stack;
extern char end_stack;

// provided by libasmrun.a
// extern "C" {
    extern void caml_startup(const char** argv);
// }

//provided by libnolibc.a
extern void _nolibc_init(uintptr_t heap_start, uint64_t heap_size);

// provided by application
extern void main();


#endif
