// These are stubs for some library functions that are provided by nosys
// but produce warnings.
// We are now using nano, so fewer stubs are required
// https://sourceware.org/newlib/libc.html?utm_source=chatgpt.com#Stubs
//
// The functions here-in are inspired by the newlib nosys implementation
// https://sourceware.org/git/?p=newlib-cygwin.git;a=tree;f=libgloss/libnosys;h=2987d66fd512d69228afd8d481b083d210c9a313;hb=HEAD

#include <errno.h>
#include <stddef.h>
#include <sys/types.h>
#undef errno
extern int errno;

void _exit(int rc)
{
    (void)rc;
    // just abort everything
    __builtin_trap();
}

void *
_sbrk (int incr)
{
   extern char   end; // Set by linker.
   static char * heap_end = NULL;
   char *        prev_heap_end = NULL;

   if (heap_end == 0)
   {
     heap_end = & end;
   }

   prev_heap_end = heap_end;
   heap_end += incr;

   return (void *) prev_heap_end;
}

int _write(int file, char *ptr, int len)
{
    (void)file;
    (void)ptr;
    (void)len;
    errno = ENOSYS;
    return -1;
}

int _close(int file)
{
    (void)file;
    errno = ENOSYS;
    return -1;
}

int _read(int file, char *ptr, int len)
{
    (void)file;
    (void)ptr;
    (void)len;
    errno = ENOSYS;
    return -1;
}

int _lseek(int file, int ptr, int dir)
{
    (void)file;
    (void)ptr;
    (void)dir;
    errno = ENOSYS;
    return -1;
}
