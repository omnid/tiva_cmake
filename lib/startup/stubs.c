// These are stubs for some library functions that are provided by nosys
// but produce warnings.
// We are now using nano, so fewer stubs are required
// https://sourceware.org/newlib/libc.html?utm_source=chatgpt.com#Stubs
//
// The functions here-in are inspired by the newlib nosys implementation
// https://sourceware.org/git/?p=newlib-cygwin.git;a=tree;f=libgloss/libnosys;h=2987d66fd512d69228afd8d481b083d210c9a313;hb=HEAD

#include <errno.h>
#include <sys/types.h>
#undef errno
extern int errno;

void _exit(int placeholder)
{
    // just abort everything
    __builtin_trap();
}

void *
_sbrk (int incr)
{
   extern char   end; // Set by linker.
   static char * heap_end;
   char *        prev_heap_end;

   if (heap_end == 0)
     heap_end = & end;

   prev_heap_end = heap_end;
   heap_end += incr;

   return (void *) prev_heap_end;
}

int _write(int placeholder1, char* placeholder2, int placeholder3)
{
    errno = ENOSYS;
    return -1;
}

int _close(int placeholder)
{
    errno = ENOSYS;
    return -1;
}

int _read(int placeholder1, char* placeholder2, int placeholder3)
{
    errno = ENOSYS;
    return -1;
}

int _lseek(int placeholder1, int placeholder2, int placeholder3)
{
    errno = ENOSYS;
    return -1;
}
