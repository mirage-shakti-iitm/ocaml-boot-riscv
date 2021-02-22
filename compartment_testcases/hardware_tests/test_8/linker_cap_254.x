PROVIDE(pc_base_254 = . );
*(.text.boot_vprintf)
*(.text.boot_putstring)
*(.text.__check_fromhost)
*(.text.__set_tohost)
*(.text.htif_console_getchar)
*(.text.do_tohost_fromhost)
*(.text.htif_syscall)
*(.text.htif_console_putchar)
*(.text.htif_poweroff)
PROVIDE(pc_bound_254 = . );
