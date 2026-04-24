/// \file
/// \brief  Test the C startup code

// A global initialized variable, stored in the .data section
// This variable is stored in RAM and initialized by the startup code
// From value stored in flash
unsigned int data_var = 0xDEADBEEF;

// A global uninitialized variable, stored in the .bss section and initialized to 0
// This variable is stored in RAM and initialized to 0 by the startup code
unsigned int bss_var;

// a constant is stored in the .rodata section in flash
const unsigned rodata_var = 0x1337ABCD;

/// defined as the end of the stack in the linker script
extern unsigned int __STACK_END;

/// Store a test result toward the end of the stack
volatile unsigned int *test_result = &__STACK_END - sizeof(unsigned int);

void test_over(void)
{
    // empty function used to serve as a marker for a breakpoint
}

int main(void)
{
    *test_result = 0;

    /// Test the .data variable
    if (data_var != 0xDEADBEEF)
    {
        *test_result |= 0x1;
    }

    /// test the .bss variable
    if(bss_var != 0)
    {
        *test_result |= 0x2;
    }

    // test that the stack is usable
    volatile unsigned int stack_var = 0x12345678;
    if(stack_var != 0x12345678)
    {
        *test_result |= 0x4;
    }

    // test the ro data
    if(rodata_var != 0x1337ABCD)
    {
        *test_result |= 0x8;
    }

    test_over();

    return 0;
}
