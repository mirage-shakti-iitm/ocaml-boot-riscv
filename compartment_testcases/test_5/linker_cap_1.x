PROVIDE(pc_base_1 = . );
*(.text.boot_primary)
*(.text.__check_fromhost)
*(.text.__set_tohost)
*(.text.do_tohost_fromhost)
*(.text.htif_console_putchar)
PROVIDE(pc_bound_1 = . );
