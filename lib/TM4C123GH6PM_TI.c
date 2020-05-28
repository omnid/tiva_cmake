/// @brief C library startup code
extern void c_int00(void);

/// @brief This ISR is called on processor reset. It calls the c initialization routine
static void ResetISR(void)
{
    // Go to the TI C initialization routine which sets up the C runtime
    // and enables floating point. The code then calls main
    __asm("    .global _c_int00\n"
          "    b.w     _c_int00");
}

/// @brief by default this is called from each ISR
///        define your own version to override 
__attribute__((weak)) void ISR_Default() {}

/// Define the ISRs as weak symbols so that they can be overriddent
__attribute__((weak)) void NmiISR(void)
{
    error(FILE_LINE, "NMI");
}

/// @brief fault isr. These are errors that the processor can detect (such as divide by zero)
/// See section 2.6.1 of the datasheet for more information about this fault.
/// By default, loop forever so state is preserved and can be captured by the debugger.
/// This is weak so it can be overridden by user code
__attribute__((weak))
void FaultISR(void)
{
    error(FILE_LINE, "FAULT");
}

__attribute__((weak))
void Can0ISR(void)
{
    error(FILE_LINE, "CANISR");
}

// uart interrupts are triggered on error conditions, however,
// this feature must be explicitly enabled.
__attribute__((weak))
void Uart0ISR(void)
{
    error(FILE_LINE, "UART0_ISR");
}

__attribute__((weak))
void Uart1ISR(void)
{
    error(FILE_LINE, "UART1_ISR");
}

__attribute__((weak))
void Uart2ISR(void)
{
    error(FILE_LINE, "UART2_ISR");
}

__attribute__((weak))
void Uart3ISR(void)
{
    error(FILE_LINE, "UART3_ISR");
}

__attribute__((weak))
void Uart4ISR(void)
{
    error(FILE_LINE, "UART4_ISR");
}

__attribute__((weak))
void Uart5ISR(void)
{
    error(FILE_LINE, "UART5_ISR");
}

__attribute__((weak))
void Uart6ISR(void)
{
    error(FILE_LINE, "UART6_ISR");
}

__attribute__((weak))
void Uart7ISR(void)
{
    error(FILE_LINE, "UART7_ISR");
}

__attribute__((weak))
void Timer0AISR(void)
{
    error(FILE_LINE, "TIMER0A_ISR");
}

__attribute__((weak))
void Timer0BISR(void)
{
    error(FILE_LINE, "TIMER0B_ISR");
}

__attribute__((weak))
void Timer1AISR(void)
{
    error(FILE_LINE, "TIMER1A_ISR");
}

__attribute__((weak))
void Timer1BISR(void)
{
    error(FILE_LINE, "TIMER1B_ISR");
}


__attribute__((weak))
void Timer2AISR(void)
{
    error(FILE_LINE, "TIMER2A_ISR");
}

__attribute__((weak))
void Timer2BISR(void)
{
    error(FILE_LINE, "TIMER2B_ISR");
}


__attribute__((weak))
void Timer3AISR(void)
{
    error(FILE_LINE, "TIMER3A_ISR");
}

__attribute__((weak))
void Timer3BISR(void)
{
    error(FILE_LINE, "TIMER3B_ISR");
}


__attribute__((weak))
void Timer4AISR(void)
{
    error(FILE_LINE, "TIMER4A_ISR");
}

__attribute__((weak))
void Timer4BISR(void)
{
    error(FILE_LINE, "TIMER4B_ISR");
}


__attribute__((weak))
void Timer5AISR(void)
{
    error(FILE_LINE, "TIMER5A_ISR");
}

__attribute__((weak))
void Timer5BISR(void)
{
    error(FILE_LINE, "TIMER5B_ISR");
}
/// @brief default isr handler
__attribute__((weak))
void IntDefaultHandler(void)
{
    // as you need interrupts add them here.  for now this
    // default is to remind you
    error(FILE_LINE, "UNDEFINED");
}


// a variable holding the top of the stack address
// we need t
extern uintptr_t __STACK_END;

// The vector table.  Note that the proper constructs must be placed on this to
// ensure that it ends up at physical address 0x0000.0000 or at the start of
// the program if located at a start address other than 0.
//
// this is placed at .intvecs section by the linker script
__attribute__ ((section(".intvecs"))) 
void (* const tlib_int_vectors[])(void) =
{
    // initial stack pointer (defined in linker script)
    (void (*)(void))(uint32_t)&__STACK_END, 
    
    ResetISR,                 // 1    The reset handler
    NonMaskableInterruptISR,  // 2    The NMI handler
    HardFaultISR,             // 3    The hard fault handler
    MemoryManagementISR,      // 4    The MPU fault handler
    BusFaultISR,              // 5    The bus fault handler
    UsageFaultISR,            // 6    The usage fault handler
    0,                        // 7    Reserved
    0,                        // 8    Reserved
    0,                        // 9    Reserved
    0,                        // 10   Reserved
    SVCallISR,                // 11   SVCall handler
    DebugMonitorISR,          // 12   Debug monitor handler
    0,                        // 13   Reserved
    PendSVISR,                // 14   The PendSV handler
    SysTickISR,               // 15   The SysTick handler
    GPIOPortAISR,             // 16   GPIO Port A
    GPIOPortBISR,             // 17   GPIO Port B
    GPIOPortCISR,             // 18   GPIO Port C
    GPIOPortDISR,             // 19   GPIO Port D
    GPIOPortEISR,             // 20   GPIO Port E
    Uart0ISR,                 // 21   UART0 Rx and Tx
    UART1ISR,                 // 22   UART1 Rx and Tx
    SSI0ISR,                  // 23   SSI0 Rx and Tx
    I2C0ISR,                  // 24   I2C0 Master and Slave
    PWM0FaultISR,             // 25   PWM Fault
    PWM0Generator0ISR,        // 26   PWM Generator 0
    PWM0Generator1ISR,        // 27   PWM Generator 1
    PWM0Generator2ISR,        // 28   PWM Generator 2
    QEI0ISR,                  // 29   Quadrature Encoder 0
    ADC0Sequence0ISR,         // 30   ADC Sequence 0
    ADC0Sequence1ISR,         // 31   ADC Sequence 1
    ADC0Sequence2ISR,         // 32   ADC Sequence 2
    ADC0Sequence3ISR,         // 33   ADC Sequence 3
    WatchdogTimers0and1ISR,   // 34   Watchdog timer
    Timer0AISR,               // 35   Timer 0 subtimer A
    Timer0BISR,               // 36   Timer 0 subtimer B
    Timer1AISR,               // 37   Timer 1 subtimer A
    Timer1BISR,               // 38   Timer 1 subtimer B
    Timer2AISR,               // 39   Timer 2 subtimer A
    Timer2BISR,               // 40   Timer 2 subtimer B
    AnalogComparator0ISR,     // 41   Analog Comparator 0
    AnalogComparator1ISR,     // 42   Analog Comparator 1
    0,                        // 43   Reserved
    SystemControlISR,         // 44   System Control (PLL, OSC, BO)
    FlashAndEEPROMISR,        // 45   FLASH Control
    GPIOPortFISR,             // 46   GPIO Port F
    0,                        // 47   Reserved
    0,                        // 48   Reserved
    UART2ISR,                 // 49   UART2 Rx and Tx
    SSI1ISR,                  // 50   SSI1 Rx and Tx
    Timer3AISR,               // 51   Timer 3 subtimer A
    Timer3BISR,               // 52   Timer 3 subtimer B
    I2C1ISR,                  // 53   I2C1 Master and Slave
    QEI1ISR,                  // 54   Quadrature Encoder 1
    Can0ISR,                  // 55   CAN0
    Can1ISR,                  // 56   CAN1
    0,                        // 57   Reserved
    0,                        // 58   Reserved
    HibernationModuleISR,     // 59   Hibernate
    USBISR,                   // 60   USB0
    PWMGenerator3ISR,         // 61   PWM Generator 3
    uDMASoftwareISR,          // 62   uDMA Software Transfer
    uDMAErrorISR,             // 63   uDMA Error
    ADC1Sequence0ISR,         // 64   ADC1 Sequence 0
    ADC1Sequence1ISR,         // 65   ADC1 Sequence 1
    ADC1Sequence2ISR,         // 66   ADC1 Sequence 2
    ADC1Sequence3ISR,         // 67   ADC1 Sequence 3
    0,                        // 68   Reserved
    0,                        // 69   Reserved
    0,                        // 70   Reserved
    0,                        // 71   Reserved
    0,                        // 72   Reserved
    SSI2ISR,                  // 73   SSI2 Rx and Tx
    SSI3ISR,                  // 74   SSI3 Rx and Tx
    UART3ISR,                 // 75   UART3 Rx and Tx
    UART4ISR,                 // 76   UART4 Rx and Tx
    UART5ISR,                 // 77   UART5 Rx and Tx
    UART6ISR,                 // 78   UART6 Rx and Tx
    UART7ISR,                 // 79   UART7 Rx and Tx
    0,                        // 80   Reserved
    0,                        // 81   Reserved
    0,                        // 82   Reserved
    0,                        // 83   Reserved
    I2C2ISR,                  // 84   I2C2 Master and Slave
    I2C3ISR,                  // 85   I2C3 Master and Slave
    Timer4AISR,               // 86   Timer 4 subtimer A
    Timer4BISR,               // 87   Timer 4 subtimer B
    0,                        // 88   Reserved
    0,                        // 89   Reserved
    0,                        // 90   Reserved
    0,                        // 91   Reserved
    0,                        // 92   Reserved
    0,                        // 93   Reserved
    0,                        // 94   Reserved
    0,                        // 95   Reserved
    0,                        // 96   Reserved
    0,                        // 97   Reserved
    0,                        // 98   Reserved
    0,                        // 99   Reserved
    0,                        // 100  Reserved
    0,                        // 101  Reserved
    0,                        // 102  Reserved
    0,                        // 103  Reserved
    0,                        // 104  Reserved
    0,                        // 105  Reserved
    0,                        // 106  Reserved
    0,                        // 107  Reserved
    Timer5AISR,               // 108  Timer 5 subtimer A
    Timer5BISR,               // 109  Timer 5 subtimer B
    WTimer0AISR,              // 110  Wide Timer 0 subtimer A
    WTimer0BISR,              // 111  Wide Timer 0 subtimer B
    WTimer1AISR,              // 112  Wide Timer 1 subtimer A
    WTimer1BISR,              // 113  Wide Timer 1 subtimer B
    WTimer2AISR,              // 114  Wide Timer 2 subtimer A
    WTimer2BISR,              // 115  Wide Timer 2 subtimer B
    WTimer3AISR,              // 116  Wide Timer 3 subtimer A
    WTimer3BISR,              // 117  Wide Timer 3 subtimer B
    WTimer4AISR,              // 118  Wide Timer 4 subtimer A
    WTimer4BISR,              // 119  Wide Timer 4 subtimer B
    WTimer5AISR,              // 120  Wide Timer 5 subtimer A
    WTimer5BISR,              // 121  Wide Timer 5 subtimer B
    SystemExceptionISR,       // 122  FPU
    0,                        // 123  Reserved
    0,                        // 124  Reserved
    0,                        // 125  Reserved
    0,                        // 126  Reserved
    0,                        // 127  Reserved
    0,                        // 128  Reserved
    0,                        // 129  Reserved
    0,                        // 130  Reserved
    0,                        // 131  Reserved
    0,                        // 132  Reserved
    0,                        // 133  Reserved
    0,                        // 134  Reserved
    0,                        // 135  Reserved
    0,                        // 136  Reserved
    0,                        // 137  Reserved
    0,                        // 138  Reserved
    0,                        // 139  Reserved
    0,                        // 140  Reserved
    0,                        // 141  Reserved
    0,                        // 142  Reserved
    0,                        // 143  Reserved
    0,                        // 144  Reserved
    0,                        // 145  Reserved
    0,                        // 146  Reserved
    0,                        // 147  Reserved
    0,                        // 148  Reserved
    0,                        // 149  Reserved
    PWM1Generator0ISR,        // 150  PWM 1 Generator 0
    PWM1Generator1ISR,        // 151  PWM 1 Generator 1
    PWM1Generator2ISR,        // 152  PWM 1 Generator 2
    PWM1Generator3ISR,        // 153  PWM 1 Generator 3
    PWM1FaultISR              // 154  PWM 1 Fault
};


