#ifndef __OUTPUT_H__
#define __OUTPUT_H__

#include "ostream.h"

class HTIFOutputStream : public O_Stream<HTIFOutputStream> {
public:
	HTIFOutputStream() {};
	void putchar(char c);
};

class UARTOutputStream : public O_Stream<UARTOutputStream> {
public:
	UARTOutputStream() {};
	void putchar(char c);
};

#ifdef HTIF
extern HTIFOutputStream kout;
#endif
#ifdef UART
extern UARTOutputStream kout;
#endif

#endif // __OUTPUT_H__
