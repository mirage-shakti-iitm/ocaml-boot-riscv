#ifndef __ASSERT_H
#define __ASSERT_H

#include "print.h"

#define assert(x) do {                                          \
  if (!(x)) {                                                   \
     printf("Assertion '%s' failed in file/line %s:%s\n",#x, __FILE__, __LINE__);               \
    while(1);                                                  \
  } } while(0)                                                  \

#endif
