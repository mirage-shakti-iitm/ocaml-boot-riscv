PROVIDE(pc_base_255 = . );
*(.text.vprintf)
*(.text.printf)
*(.text.putstring)
*(.text.__check_fromhost_exception)
*(.text.__set_tohost_exception)
*(.text.htif_console_getchar_exception)
*(.text.do_tohost_fromhost_exception)
*(.text.htif_console_putchar_exception)
*(.text.trap_handler)
*(.text.print_checkcap_all_cond_fail)
*(.text.print_capability_fail)
*(.text.vprintf_exception)
*(.text.printf_exception)
*(.text.putstring_exception)
*(.text.__check_fromhost)
*(.text.__set_tohost)
*(.text.do_tohost_fromhost)
*(.text.htif_console_putchar)
*(.text.htif_poweroff)
*(.text*)
PROVIDE(pc_bound_255 = . );
