PROVIDE(pc_base_0 = . );
KEEP(*(.text.init))
*(.text.boot_vprintf)
*(.text.boot_primary)
*(.text.uart_putchar)
PROVIDE(pc_bound_0 = . );
