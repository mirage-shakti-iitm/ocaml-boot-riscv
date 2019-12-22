#ifndef timer_h
#define timer_h

    bool timer_pending();
    void set_timer(unsigned long long deadline);
    void clear_timer();

#endif
