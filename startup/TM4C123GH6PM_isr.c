/// @file
/// @brief The default ISR handlers for the TM4C123GH6PM
///   All interrupts are weak aliases to DefaultISR and can be overriden in
///   user code

extern void ResetISR(void);

/// @brief by default this is called from each ISR
///        define your own version to override 
__attribute__((weak)) void DefaultISR(void)
{
    // do nothing
}

/// @brief ISR for Interrupt Vector 2, The NMI handler.
/// This just is another name for DefaultISR unless it is defined elsewhere
void NonMaskableInterruptISR(void) __attribute__((weak, alias ("DefaultISR")));

/// @brief ISR for Interrupt Vector 3,    The hard fault handler
/// This just is another name for DefaultISR unless it is defined elsewhere
void HardFaultISR(void) __attribute__((weak, alias ("DefaultISR")));

/// @brief ISR for Interrupt Vector 4, The MPU fault handler
/// This just is another name for DefaultISR unless it is defined elsewhere
void MemoryManagementISR(void) __attribute__((weak, alias ("DefaultISR")));

/// @brief ISR for Interrupt Vector 5, The bus fault handler
/// This just is another name for DefaultISR unless it is defined elsewhere
void BusFaultISR(void) __attribute__((weak, alias ("DefaultISR")));

/// @brief ISR for Interrupt Vector 6, The usage fault handler
/// This just is another name for DefaultISR unless it is defined elsewhere
void UsageFaultISR(void) __attribute__((weak, alias ("DefaultISR")));

/// @brief ISR for Interrupt Vector 11, SVCall handler
/// This just is another name for DefaultISR unless it is defined elsewhere
void SVCallISR(void) __attribute__((weak, alias ("DefaultISR")));

/// @brief ISR for Interrupt Vector 12, Debug monitor handler
/// This just is another name for DefaultISR unless it is defined elsewhere
void DebugMonitorISR(void) __attribute__((weak, alias ("DefaultISR")));

/// @brief ISR for Interrupt Vector 14, The PendSV handler
/// This just is another name for DefaultISR unless it is defined elsewhere
void PendSVISR(void) __attribute__((weak, alias ("DefaultISR")));

/// @brief ISR for Interrupt Vector 15, The SysTick handler
/// This just is another name for DefaultISR unless it is defined elsewhere
void SysTickISR(void) __attribute__((weak, alias ("DefaultISR")));

/// @brief ISR for Interrupt Vector 16, GPIO Port A
/// This just is another name for DefaultISR unless it is defined elsewhere
void GPIOPortAISR(void) __attribute__((weak, alias ("DefaultISR")));

/// @brief ISR for Interrupt Vector 17, GPIO Port B
/// This just is another name for DefaultISR unless it is defined elsewhere
void GPIOPortBISR(void) __attribute__((weak, alias ("DefaultISR")));

/// @brief ISR for Interrupt Vector 18, GPIO Port C
/// This just is another name for DefaultISR unless it is defined elsewhere
void GPIOPortCISR(void) __attribute__((weak, alias ("DefaultISR")));

/// @brief ISR for Interrupt Vector 19, GPIO Port D
/// This just is another name for DefaultISR unless it is defined elsewhere
void GPIOPortDISR(void) __attribute__((weak, alias ("DefaultISR")));

/// @brief ISR for Interrupt Vector 20, GPIO Port E
/// This just is another name for DefaultISR unless it is defined elsewhere
void GPIOPortEISR(void) __attribute__((weak, alias ("DefaultISR")));

/// @brief ISR for Interrupt Vector 21, UART0 Rx and Tx
/// This just is another name for DefaultISR unless it is defined elsewhere
void Uart0ISR(void) __attribute__((weak, alias ("DefaultISR")));

/// @brief ISR for Interrupt Vector 22, UART1 Rx and Tx
/// This just is another name for DefaultISR unless it is defined elsewhere
void UART1ISR(void) __attribute__((weak, alias ("DefaultISR")));

/// @brief ISR for Interrupt Vector 23, SSI0 Rx and Tx
/// This just is another name for DefaultISR unless it is defined elsewhere
void SSI0ISR(void) __attribute__((weak, alias ("DefaultISR")));

/// @brief ISR for Interrupt Vector 24, I2C0 Master and Slave
/// This just is another name for DefaultISR unless it is defined elsewhere
void I2C0ISR(void) __attribute__((weak, alias ("DefaultISR")));

/// @brief ISR for Interrupt Vector 25, PWM Fault
/// This just is another name for DefaultISR unless it is defined elsewhere
void PWM0FaultISR(void) __attribute__((weak, alias ("DefaultISR")));

/// @brief ISR for Interrupt Vector 26, PWM Generator 0
/// This just is another name for DefaultISR unless it is defined elsewhere
void PWM0Generator0ISR(void) __attribute__((weak, alias ("DefaultISR")));

/// @brief ISR for Interrupt Vector 27, PWM Generator 1
/// This just is another name for DefaultISR unless it is defined elsewhere
void PWM0Generator1ISR(void) __attribute__((weak, alias ("DefaultISR")));

/// @brief ISR for Interrupt Vector 28, PWM Generator 2
/// This just is another name for DefaultISR unless it is defined elsewhere
void PWM0Generator2ISR(void) __attribute__((weak, alias ("DefaultISR")));

/// @brief ISR for Interrupt Vector 29, Quadrature Encoder 0
/// This just is another name for DefaultISR unless it is defined elsewhere
void QEI0ISR(void) __attribute__((weak, alias ("DefaultISR")));

/// @brief ISR for Interrupt Vector 30, ADC Sequence 0
/// This just is another name for DefaultISR unless it is defined elsewhere
void ADC0Sequence0ISR(void) __attribute__((weak, alias ("DefaultISR")));

/// @brief ISR for Interrupt Vector 31, ADC Sequence 1
/// This just is another name for DefaultISR unless it is defined elsewhere
void ADC0Sequence1ISR(void) __attribute__((weak, alias ("DefaultISR")));

/// @brief ISR for Interrupt Vector 32, ADC Sequence 2
/// This just is another name for DefaultISR unless it is defined elsewhere
void ADC0Sequence2ISR(void) __attribute__((weak, alias ("DefaultISR")));

/// @brief ISR for Interrupt Vector 33, ADC Sequence 3
/// This just is another name for DefaultISR unless it is defined elsewhere
void ADC0Sequence3ISR(void) __attribute__((weak, alias ("DefaultISR")));

/// @brief ISR for Interrupt Vector 34, Watchdog timer
/// This just is another name for DefaultISR unless it is defined elsewhere
void WatchdogTimers0and1ISR(void) __attribute__((weak, alias ("DefaultISR")));

/// @brief ISR for Interrupt Vector 35, Timer 0 subtimer A
/// This just is another name for DefaultISR unless it is defined elsewhere
void Timer0AISR(void) __attribute__((weak, alias ("DefaultISR")));

/// @brief ISR for Interrupt Vector 36, Timer 0 subtimer B
/// This just is another name for DefaultISR unless it is defined elsewhere
void Timer0BISR(void) __attribute__((weak, alias ("DefaultISR")));

/// @brief ISR for Interrupt Vector 37, Timer 1 subtimer A
/// This just is another name for DefaultISR unless it is defined elsewhere
void Timer1AISR(void) __attribute__((weak, alias ("DefaultISR")));

/// @brief ISR for Interrupt Vector 38, Timer 1 subtimer B
/// This just is another name for DefaultISR unless it is defined elsewhere
void Timer1BISR(void) __attribute__((weak, alias ("DefaultISR")));

/// @brief ISR for Interrupt Vector 39, Timer 2 subtimer A
/// This just is another name for DefaultISR unless it is defined elsewhere
void Timer2AISR(void) __attribute__((weak, alias ("DefaultISR")));

/// @brief ISR for Interrupt Vector 40, Timer 2 subtimer B
/// This just is another name for DefaultISR unless it is defined elsewhere
void Timer2BISR(void) __attribute__((weak, alias ("DefaultISR")));

/// @brief ISR for Interrupt Vector 41, Analog Comparator 0
/// This just is another name for DefaultISR unless it is defined elsewhere
void AnalogComparator0ISR(void) __attribute__((weak, alias ("DefaultISR")));

/// @brief ISR for Interrupt Vector 42, Analog Comparator 1
/// This just is another name for DefaultISR unless it is defined elsewhere
void AnalogComparator1ISR(void) __attribute__((weak, alias ("DefaultISR")));

/// @brief ISR for Interrupt Vector 44, System Control (PLL, OSC, BO)
/// This just is another name for DefaultISR unless it is defined elsewhere
void SystemControlISR(void) __attribute__((weak, alias ("DefaultISR")));

/// @brief ISR for Interrupt Vector 45, FLASH Control
/// This just is another name for DefaultISR unless it is defined elsewhere
void FlashAndEEPROMISR(void) __attribute__((weak, alias ("DefaultISR")));

/// @brief ISR for Interrupt Vector 46, GPIO Port F
/// This just is another name for DefaultISR unless it is defined elsewhere
void GPIOPortFISR(void) __attribute__((weak, alias ("DefaultISR")));

/// @brief ISR for Interrupt Vector 49, UART2 Rx and Tx
/// This just is another name for DefaultISR unless it is defined elsewhere
void UART2ISR(void) __attribute__((weak, alias ("DefaultISR")));

/// @brief ISR for Interrupt Vector 50, SSI1 Rx and Tx
/// This just is another name for DefaultISR unless it is defined elsewhere
void SSI1ISR(void) __attribute__((weak, alias ("DefaultISR")));

/// @brief ISR for Interrupt Vector 51, Timer 3 subtimer A
/// This just is another name for DefaultISR unless it is defined elsewhere
void Timer3AISR(void) __attribute__((weak, alias ("DefaultISR")));

/// @brief ISR for Interrupt Vector 52, Timer 3 subtimer B
/// This just is another name for DefaultISR unless it is defined elsewhere
void Timer3BISR(void) __attribute__((weak, alias ("DefaultISR")));

/// @brief ISR for Interrupt Vector 53, I2C1 Master and Slave
/// This just is another name for DefaultISR unless it is defined elsewhere
void I2C1ISR(void) __attribute__((weak, alias ("DefaultISR")));

/// @brief ISR for Interrupt Vector 54, Quadrature Encoder 1
/// This just is another name for DefaultISR unless it is defined elsewhere
void QEI1ISR(void) __attribute__((weak, alias ("DefaultISR")));

/// @brief ISR for Interrupt Vector 55, CAN0
/// This just is another name for DefaultISR unless it is defined elsewhere
void Can0ISR(void) __attribute__((weak, alias ("DefaultISR")));

/// @brief ISR for Interrupt Vector 56, CAN1
/// This just is another name for DefaultISR unless it is defined elsewhere
void Can1ISR(void) __attribute__((weak, alias ("DefaultISR")));

/// @brief ISR for Interrupt Vector 59, Hibernate
/// This just is another name for DefaultISR unless it is defined elsewhere
void HibernationModuleISR(void) __attribute__((weak, alias ("DefaultISR")));

/// @brief ISR for Interrupt Vector 60, USB0
/// This just is another name for DefaultISR unless it is defined elsewhere
void USBISR(void) __attribute__((weak, alias ("DefaultISR")));

/// @brief ISR for Interrupt Vector 61, PWM Generator 3
/// This just is another name for DefaultISR unless it is defined elsewhere
void PWMGenerator3ISR(void) __attribute__((weak, alias ("DefaultISR")));

/// @brief ISR for Interrupt Vector 62, uDMA Software Transfer
/// This just is another name for DefaultISR unless it is defined elsewhere
void uDMASoftwareISR(void) __attribute__((weak, alias ("DefaultISR")));

/// @brief ISR for Interrupt Vector 63, uDMA Error
/// This just is another name for DefaultISR unless it is defined elsewhere
void uDMAErrorISR(void) __attribute__((weak, alias ("DefaultISR")));

/// @brief ISR for Interrupt Vector 64, ADC1 Sequence 0
/// This just is another name for DefaultISR unless it is defined elsewhere
void ADC1Sequence0ISR(void) __attribute__((weak, alias ("DefaultISR")));

/// @brief ISR for Interrupt Vector 65, ADC1 Sequence 1
/// This just is another name for DefaultISR unless it is defined elsewhere
void ADC1Sequence1ISR(void) __attribute__((weak, alias ("DefaultISR")));

/// @brief ISR for Interrupt Vector 66, ADC1 Sequence 2
/// This just is another name for DefaultISR unless it is defined elsewhere
void ADC1Sequence2ISR(void) __attribute__((weak, alias ("DefaultISR")));

/// @brief ISR for Interrupt Vector 67, ADC1 Sequence 3
/// This just is another name for DefaultISR unless it is defined elsewhere
void ADC1Sequence3ISR(void) __attribute__((weak, alias ("DefaultISR")));

/// @brief ISR for Interrupt Vector 73, SSI2 Rx and Tx
/// This just is another name for DefaultISR unless it is defined elsewhere
void SSI2ISR(void) __attribute__((weak, alias ("DefaultISR")));

/// @brief ISR for Interrupt Vector 74, SSI3 Rx and Tx
/// This just is another name for DefaultISR unless it is defined elsewhere
void SSI3ISR(void) __attribute__((weak, alias ("DefaultISR")));

/// @brief ISR for Interrupt Vector 75, UART3 Rx and Tx
/// This just is another name for DefaultISR unless it is defined elsewhere
void UART3ISR(void) __attribute__((weak, alias ("DefaultISR")));

/// @brief ISR for Interrupt Vector 76, UART4 Rx and Tx
/// This just is another name for DefaultISR unless it is defined elsewhere
void UART4ISR(void) __attribute__((weak, alias ("DefaultISR")));

/// @brief ISR for Interrupt Vector 77, UART5 Rx and Tx
/// This just is another name for DefaultISR unless it is defined elsewhere
void UART5ISR(void) __attribute__((weak, alias ("DefaultISR")));

/// @brief ISR for Interrupt Vector 78, UART6 Rx and Tx
/// This just is another name for DefaultISR unless it is defined elsewhere
void UART6ISR(void) __attribute__((weak, alias ("DefaultISR")));

/// @brief ISR for Interrupt Vector 79, UART7 Rx and Tx
/// This just is another name for DefaultISR unless it is defined elsewhere
void UART7ISR(void) __attribute__((weak, alias ("DefaultISR")));

/// @brief ISR for Interrupt Vector 84, I2C2 Master and Slave
/// This just is another name for DefaultISR unless it is defined elsewhere
void I2C2ISR(void) __attribute__((weak, alias ("DefaultISR")));

/// @brief ISR for Interrupt Vector 85, I2C3 Master and Slave
/// This just is another name for DefaultISR unless it is defined elsewhere
void I2C3ISR(void) __attribute__((weak, alias ("DefaultISR")));

/// @brief ISR for Interrupt Vector 86, Timer 4 subtimer A
/// This just is another name for DefaultISR unless it is defined elsewhere
void Timer4AISR(void) __attribute__((weak, alias ("DefaultISR")));

/// @brief ISR for Interrupt Vector 87, Timer 4 subtimer B
/// This just is another name for DefaultISR unless it is defined elsewhere
void Timer4BISR(void) __attribute__((weak, alias ("DefaultISR")));

/// @brief ISR for Interrupt Vector 108, Timer 5 subtimer A
/// This just is another name for DefaultISR unless it is defined elsewhere
void Timer5AISR(void) __attribute__((weak, alias ("DefaultISR")));

/// @brief ISR for Interrupt Vector 109, Timer 5 subtimer B
/// This just is another name for DefaultISR unless it is defined elsewhere
void Timer5BISR(void) __attribute__((weak, alias ("DefaultISR")));

/// @brief ISR for Interrupt Vector 110, Wide Timer 0 subtimer A
/// This just is another name for DefaultISR unless it is defined elsewhere
void WTimer0AISR(void) __attribute__((weak, alias ("DefaultISR")));

/// @brief ISR for Interrupt Vector 111, Wide Timer 0 subtimer B
/// This just is another name for DefaultISR unless it is defined elsewhere
void WTimer0BISR(void) __attribute__((weak, alias ("DefaultISR")));

/// @brief ISR for Interrupt Vector 112, Wide Timer 1 subtimer A
/// This just is another name for DefaultISR unless it is defined elsewhere
void WTimer1AISR(void) __attribute__((weak, alias ("DefaultISR")));

/// @brief ISR for Interrupt Vector 113, Wide Timer 1 subtimer B
/// This just is another name for DefaultISR unless it is defined elsewhere
void WTimer1BISR(void) __attribute__((weak, alias ("DefaultISR")));

/// @brief ISR for Interrupt Vector 114, Wide Timer 2 subtimer A
/// This just is another name for DefaultISR unless it is defined elsewhere
void WTimer2AISR(void) __attribute__((weak, alias ("DefaultISR")));

/// @brief ISR for Interrupt Vector 115, Wide Timer 2 subtimer B
/// This just is another name for DefaultISR unless it is defined elsewhere
void WTimer2BISR(void) __attribute__((weak, alias ("DefaultISR")));

/// @brief ISR for Interrupt Vector 116, Wide Timer 3 subtimer A
/// This just is another name for DefaultISR unless it is defined elsewhere
void WTimer3AISR(void) __attribute__((weak, alias ("DefaultISR")));

/// @brief ISR for Interrupt Vector 117, Wide Timer 3 subtimer B
/// This just is another name for DefaultISR unless it is defined elsewhere
void WTimer3BISR(void) __attribute__((weak, alias ("DefaultISR")));

/// @brief ISR for Interrupt Vector 118, Wide Timer 4 subtimer A
/// This just is another name for DefaultISR unless it is defined elsewhere
void WTimer4AISR(void) __attribute__((weak, alias ("DefaultISR")));

/// @brief ISR for Interrupt Vector 119, Wide Timer 4 subtimer B
/// This just is another name for DefaultISR unless it is defined elsewhere
void WTimer4BISR(void) __attribute__((weak, alias ("DefaultISR")));

/// @brief ISR for Interrupt Vector 120, Wide Timer 5 subtimer A
/// This just is another name for DefaultISR unless it is defined elsewhere
void WTimer5AISR(void) __attribute__((weak, alias ("DefaultISR")));

/// @brief ISR for Interrupt Vector 121, Wide Timer 5 subtimer B
/// This just is another name for DefaultISR unless it is defined elsewhere
void WTimer5BISR(void) __attribute__((weak, alias ("DefaultISR")));

/// @brief ISR for Interrupt Vector 122, FPU
/// This just is another name for DefaultISR unless it is defined elsewhere
void SystemExceptionISR(void) __attribute__((weak, alias ("DefaultISR")));

/// @brief ISR for Interrupt Vector 150, PWM 1 Generator 0
/// This just is another name for DefaultISR unless it is defined elsewhere
void PWM1Generator0ISR(void) __attribute__((weak, alias ("DefaultISR")));

/// @brief ISR for Interrupt Vector 151, PWM 1 Generator 1
/// This just is another name for DefaultISR unless it is defined elsewhere
void PWM1Generator1ISR(void) __attribute__((weak, alias ("DefaultISR")));

/// @brief ISR for Interrupt Vector 152, PWM 1 Generator 2
/// This just is another name for DefaultISR unless it is defined elsewhere
void PWM1Generator2ISR(void) __attribute__((weak, alias ("DefaultISR")));

/// @brief ISR for Interrupt Vector 153, PWM 1 Generator 3
/// This just is another name for DefaultISR unless it is defined elsewhere
void PWM1Generator3ISR(void) __attribute__((weak, alias ("DefaultISR")));

/// @brief ISR for Interrupt Vector 154, PWM 1 Fault
/// This just is another name for DefaultISR unless it is defined elsewhere
void PWM1FaultISR(void) __attribute__((weak, alias ("DefaultISR")));

// a variable holding the top of the stack address
extern unsigned int * __STACK_END;

// The vector table.  Note that the proper constructs must be placed on this to
// ensure that it ends up at physical address 0x0000.0000 or at the start of
// the program if located at a start address other than 0.
//
// this is placed at .intvecs section by the linker script
__attribute__ ((section(".intvecs"))) 
void (* const tlib_int_vectors[])(void) =
{
    // initial stack pointer (defined in linker script)
    (void (*)(void))(unsigned int)&__STACK_END, 
    
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
