PROVIDE(pc_base_2 = . );
*(.text.vprintf)
*(.text.printf)
*(.text.putstring)
*(.text.1)
*(.text.__check_fromhost)
*(.text.__set_tohost)
*(.text.do_tohost_fromhost)
*(.text.htif_console_putchar)
PROVIDE(pc_bound_2 = . );
