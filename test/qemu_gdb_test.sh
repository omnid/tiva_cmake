#!/bin/sh
# A script that will run an arm binary in qemu
# And then attach gdb and run as script
# Arguments:
# $1 qemu executable
# $2 gdb executable
# $3 elf file
# $4 gdb test script
set -eu

QEMU="$1"
GDB="$2"
ELF="$3"
TEST="$4"

$QEMU \
    -M mps2-an386 \
    -cpu cortex-m4 \
    -kernel $ELF \
    -nographic \
    -S \
    -gdb tcp::1234 > /dev/null 2>&1 &

# Be sure to kill QEMU whenever the script exits
PID=$!
trap 'kill $PID > /dev/null 2>&1 || true' EXIT

$GDB -q -batch -x $TEST $ELF > /dev/null 2>&1
