PROVIDE(pc_base_1 = . );
*(.text.vprintf)
*(.text.printf)
*(.text.putstring)
*(.text.boot_primary)
*(.text.2)
*(.text.__check_fromhost)
*(.text.__set_tohost)
*(.text.do_tohost_fromhost)
PROVIDE(pc_bound_1 = . );
