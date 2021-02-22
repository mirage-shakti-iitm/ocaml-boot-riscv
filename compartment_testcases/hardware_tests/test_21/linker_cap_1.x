PROVIDE(pc_base_1 = . );
*(.text.boot_printf)
*(.text.boot_putstring)
*(.text.0)
*(.text.2)
PROVIDE(pc_bound_1 = . );
