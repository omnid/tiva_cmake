// These are stubs for some library functions that are provided by nosys.
// These now produce warnings if used, so here we implement them to explicitly
/// suppress the warnings

int _close(int)
{
    return -1;
}

int _lseek(int, int, int)
{
    return 0;
}

int _read(int, char*, int)
{
    return 0;
}

int _write(int, char*, int)
{
    return 0;
}
