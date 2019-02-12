// functions exposed to ocaml-freestanding
extern "C" {
    void riscv_poweroff();
    void riscv_write(const char* s, unsigned int length);
    unsigned long long riscv_clock_monotonic();
}

// provided by the linker
extern char __KERNEL_END;

// provided by ocaml-freestanding
extern "C" {
    void caml_startup(char**);
    void _nolibc_init(unsigned long heap_start, unsigned long heap_size);
}
