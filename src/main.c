/// \file
/// \brief Example that uses driverlib to flash some leds
///        Specifically works on the EKTM4C123GXL LaunchPad dev board
#include <stdint.h>
#include <stdbool.h>
#include "driverlib/sysctl.h"
#include "driverlib/gpio.h"
#include "inc/hw_memmap.h"
int main(void)
{
    // Setup clock frequency to 80MHz
    SysCtlClockSet(
        SYSCTL_OSC_MAIN        // Use the main oscillator
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

    GPIOPinWrite(GPIO_PORTF_BASE, GPIO_PIN_2 | GPIO_PIN_2, GPIO_PIN_2 | GPIO_PIN_2);

    while(true)
    {
        ; // loop forever
    }
}
