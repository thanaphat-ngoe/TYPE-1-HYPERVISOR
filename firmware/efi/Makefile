.POSIX:
.PHONY: all clean

TARGET  = bootx64.efi
SOURCE  = efi.c
HEADERS = efi.h

# Cross-compiler for macOS to output PE/COFF natively
CC = x86_64-w64-mingw32-gcc

# Tell the compiler to look in the current directory (.) for headers
INCLUDES = -I.

# Compilation flags
CFLAGS = \
    -std=c17 \
    -Wall \
    -Wextra \
    -Wpedantic \
    -mno-red-zone \
    -ffreestanding \
    -nostdlib \
    -fshort-wchar \
    $(INCLUDES)

# Linker flags for UEFI PE/COFF
LDFLAGS = \
    -shared \
    -Wl,-dll \
    -Wl,--subsystem,10 \
    -e efi_main

all: $(TARGET)

# Build target depends on the source and header files
$(TARGET): $(SOURCE) $(HEADERS)
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $(SOURCE)

clean:
	rm -f $(TARGET)
