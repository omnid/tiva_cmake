/// \file
/// \brief Example that uses driverlib to flash some leds
///        Specifically works on the EKTM4C123GXL LaunchPad dev board
#include "driverlib/sysctl"

int main(void)
{
    // Setup clock frequency to 80MHz
    SysCtlClockSet(
        SYSTL_OSC_MAIN        // Use the main oscillator
        | SYSCTL_XTAL_16MHZ   // which is a 16 MHz crystal
        | SYSCTL_USE_PLL      // Feed PLL which results in 400 MHz
        | SYSCTL_SYSDIV_2_5   // (400 MHz /2) /2.5) = 80 MHz
        );


    // Enable the port F pins
    SysCtlPeripheralEnable(SYSCTL_PERIPH_GPIOF);
    while(!SysCtlPeripheralReady(SYSCTL_PERIPH_GPIOF))
    {
        ; // do nothing, wait for port to be ready
    }

    // set led pins as outputs
    GPIOPinTypeGPIOOutput(GPIO_PORTF_BASE, GPIO_PIN_1 | GPIO_PIN_2 | GPIO_PIN_3);

    GPIOPinWrite(GPIO_PORTF_BASE, GPIO_PIN_2 | GPIO_PIN_2);

    while(1)
    {
        ; // loop forever
    }
    
    return 0;
}
