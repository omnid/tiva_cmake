/// @brief C library startup code
extern void c_int00(void);

/// @brief This ISR is called on processor reset. It calls the c initialization routine
///        Define your own function of the same name to override the behavior
__attribute__((weak)) void ResetISR(void)
{
    // Go to the TI C initialization routine which sets up the C runtime
    // and enables floating point. That code then calls main
    __asm("    .global _c_int00\n"
          "    b.w     _c_int00");
}

