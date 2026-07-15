/// \file
/// \brief Example that uses driverlib to flash some leds
///        Specifically works on the EKTM4C123GXL LaunchPad dev board
#include <stdint.h>
#include <stdbool.h>
#include "driverlib/sysctl.h"
#include "driverlib/gpio.h"
#include "driverlib/timer.h"
#include "driverlib/interrupt.h"
#include "inc/hw_memmap.h"
#include "inc/hw_ints.h"

/// \brief interrupt for Timer0A. Toggle between blue and white
void Timer0AISR(void)
{
    TimerIntClear(TIMER0_BASE, TIMER_A);
    static bool blue = false;
    if(!blue)
    {
        GPIOPinWrite(GPIO_PORTF_BASE, GPIO_PIN_1 | GPIO_PIN_2 | GPIO_PIN_3, GPIO_PIN_2);
        blue = true;
    }
    else
    {
        GPIOPinWrite(GPIO_PORTF_BASE, GPIO_PIN_1 | GPIO_PIN_2 | GPIO_PIN_3, GPIO_PIN_1 | GPIO_PIN_2 | GPIO_PIN_3);
        blue = false;
    }
}

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

    // Enable the timer0
    SysCtlPeripheralEnable(SYSCTL_PERIPH_TIMER0);
    while(!SysCtlPeripheralReady(SYSCTL_PERIPH_TIMER0))
    {
        ; // do nothing wait for the timer module to be ready
    }

    // configure timer0 to run at 1Hz
    TimerConfigure(TIMER0_BASE, TIMER_CFG_PERIODIC); 

    // clock frequency is 80Mhz/freq (80000000/1)
    TimerLoadSet(TIMER0_BASE, TIMER_A, 80000000);

    // Enable the interrupt on the timer
    TimerIntEnable(TIMER0_BASE, TIMER_TIMA_TIMEOUT);

    // Enable timer interrupt on the nvic
    IntEnable(INT_TIMER0A);

    // Enable the timer itself
    TimerEnable(TIMER0_BASE, TIMER_A);

    // enable interrupts
    IntMasterEnable();

    for(;;)
    {
        ; // loop forever
    }
}
