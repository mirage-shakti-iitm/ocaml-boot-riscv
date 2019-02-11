// see LICENSE for licensing details
#ifndef atomic_h
#define atomic_h

// taken from pk's atomic.h
#define atomic_read(ptr) (*(volatile typeof(*(ptr)) *)(ptr))
#define atomic_set(ptr, val) (*(volatile typeof(*(ptr)) *)(ptr) = val)

class Spinlock {
    private:
        Spinlock(const Spinlock& copy) = delete;
        int locked;
    public:
        Spinlock(): locked(0) { }

        int try_lock() {
            int res = __sync_lock_test_and_set(&locked, -1);
            __sync_synchronize();
            return res;
        }
        void lock() {
            // taken from pk's atomic.h
            do {
                while(atomic_read(&locked));
            } while(try_lock());
        }

        void unlock() {
            __sync_synchronize();
            __sync_lock_release(&locked);
        }
};


class Ticketlock {
    private:
        Ticketlock(const Ticketlock& copy) = delete;
        int now_serving;
        int next_ticket;
    public:
        Ticketlock(): now_serving(0), next_ticket(0) {}

        void lock() {
            int my_ticket = __sync_fetch_and_add(&next_ticket, 1);
            __sync_synchronize();
            while(my_ticket != now_serving) {
                atomic_read(&now_serving);
            }
        }
        void unlock() {
            __sync_synchronize();
            __sync_fetch_and_add(&now_serving, 1);
        }
};

#endif
