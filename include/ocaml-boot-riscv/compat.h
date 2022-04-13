// functions exposed to ocaml-freestanding
// these need to not be name mangled

#ifdef __cplusplus
extern "C" {
#endif
	typedef unsigned long long time__t;
    void riscv_poweroff(int status) __attribute__((noreturn));
    void riscv_write(const char* s, unsigned int length);
    time__t riscv_clock_monotonic();
    time__t riscv_cycle_counter();
    void riscv_wait(time__t delay);

#ifdef __cplusplus
}
#endif