// include headers that are exported (and avoid name mangling)
extern "C" {
#include <ocaml-boot-riscv.h>
}
// provided by the linker
extern char __KERNEL_END;

// provided by ocaml-freestanding
extern "C" {
    void caml_startup(char**);
    void _nolibc_init(unsigned long heap_start, unsigned long heap_size);
}
