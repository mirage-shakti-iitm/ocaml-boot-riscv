PROVIDE(pc_base_1 = . );
*(.text.boot_printf)
*(.text.boot_putstring)
*(.text.0)
PROVIDE(pc_bound_1 = . );
