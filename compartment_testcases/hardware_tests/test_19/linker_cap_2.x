PROVIDE(pc_base_2 = . );
*(.text.0)
*(.text.uart_putchar)
PROVIDE(pc_bound_2 = . );
