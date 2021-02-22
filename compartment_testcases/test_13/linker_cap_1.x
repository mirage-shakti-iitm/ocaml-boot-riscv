PROVIDE(pc_base_1 = . );
*(.text.vprintf)
*(.text.printf)
*(.text.boot_primary)
PROVIDE(pc_bound_1 = . );
