// functions exposed to ocaml-freestanding
extern "C" {
    void riscv_poweroff(int status);
    void riscv_write(const char* s, unsigned int length);
    unsigned long long riscv_clock_monotonic();
}
