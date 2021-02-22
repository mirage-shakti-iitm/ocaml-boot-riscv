PROVIDE(pc_base_1 = . );
*(.text.vprintf)
*(.text.printf)
*(.text.putstring)
*(.text.boot_primary)
*(.text.uart_putchar)
*(.text.uart_getchar)
*(.text.init_uart)
*(.text.__check_fromhost)
*(.text.__set_tohost)
*(.text.do_tohost_fromhost)
*(.text.htif_console_putchar)
PROVIDE(pc_bound_1 = . );
