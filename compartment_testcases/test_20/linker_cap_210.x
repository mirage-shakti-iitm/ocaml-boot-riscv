PROVIDE(pc_base_210 = . );
*(.text.riscv_poweroff)
*(.text.riscv_write)
*(.text.riscv_clock_monotonic)
*(.text.riscv_wait)
PROVIDE(pc_bound_210 = . );
