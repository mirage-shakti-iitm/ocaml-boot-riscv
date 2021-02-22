PROVIDE(pc_base_1 = . );
*(.text.printf)
*(.text.putstring)
*(.text.boot_primary)
PROVIDE(pc_bound_1 = . );
