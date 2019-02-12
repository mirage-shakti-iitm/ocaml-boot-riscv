// functions exposed to ocaml-freestanding
void riscv_poweroff(int status) __attribute__((noreturn));
void riscv_write(const char* s, unsigned int length);
unsigned long long riscv_clock_monotonic();
