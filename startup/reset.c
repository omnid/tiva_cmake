/// \file
/// \brief implement the ISR called on processor reset


/// \brief C library startup code. This is provided by the ti-cgt C standard library when using ti-cgt
///   and it is provided startup.c when using gcc
extern void c_int00(void);

/// @brief This ISR is called on processor reset. It calls the c initialization routine
///        Define your own function of the same name to override the behavior.
///        When the ResetISR is triggered the stack has not been setup so there are 
__attribute__((weak, used, naked)) void ResetISR(void)
{
    // Go to the TI C initialization routine which sets up the C runtime
    // and enables floating point (if compiling with floating point support). That code then calls main
    // We have to use an asm jump to jump directly to c_int00 or else we can corrupt the stack since the stack
    // has not yet been initialized.
    __asm("    .global _c_int00\n"
          "    b.w     _c_int00");
}
