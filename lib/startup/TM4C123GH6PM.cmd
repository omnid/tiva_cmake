// Linker script for ti-cgt-arm, used with the tm4c123g processor 
// NOTE: To specify stack size use --stack=<size> linker option
//       To specify heap use --heap=<size> linker option
// Heap is not recommended and will require modifying this file

// Keep the interrupt vector table (defined in TM4C123GH6PM_isr.c)
--retain=interrupt_vector_table

// Starting addresses of flash and SRAM
#define FLASH_BASE 0x00000000
#define SRAM_BASE 0x20000000

// The memory map
MEMORY
{
    // program is stored in FLASH and executes from FLASH 
    FLASH (RX) : origin = FLASH_BASE, length = 0x00040000
    // RAM is used for data
    SRAM (RWX) : origin = SRAM_BASE, length = 0x00008000
}

// Allocate the sections into memory
SECTIONS
{
    .intvecs:   > FLASH_BASE
    .text   :   > FLASH
    .const  :   > FLASH
    .cinit  :   > FLASH
    .pinit  :   > FLASH
    .init_array : > FLASH

    .vtable :   > SRAM_BASE
    .data   :   > SRAM
    .bss    :   > SRAM
    .sysmem :   > SRAM
    .stack  :   > SRAM
}
