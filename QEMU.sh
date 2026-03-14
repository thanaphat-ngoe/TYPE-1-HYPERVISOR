#!/bin/sh

# Exit immediately if any command fails
set -e

EFI_FILE="firmware/built/bootx64.efi"
IMG_FILE="firmware/built/DISK.img"
VOL_NAME="EFIVOL"
VOL_PATH="/Volumes/$VOL_NAME"

echo "--- Checking for EFI executable ---"
if [ ! -f "$EFI_FILE" ]; then
    echo "Error: $EFI_FILE not found! Please build your code first."
    exit 1
fi

echo "--- Creating 64MB disk image ($IMG_FILE) ---"
rm -f "$IMG_FILE"
dd if=/dev/zero of="$IMG_FILE" bs=1m count=64

echo "--- Partitioning and formatting natively on macOS ---"
# Attach without mounting to grab the disk identifier (e.g., /dev/disk4)
DISK_DEV=$(hdiutil attach -nomount "$IMG_FILE" | head -n 1 | awk '{print $1}')

# Format as GPT and FAT32. This automatically mounts it to /Volumes/EFIVOL
diskutil partitionDisk "$DISK_DEV" 1 GPT "MS-DOS FAT32" "$VOL_NAME" 100%

echo "--- Copying BOOTX64.EFI ---"
mkdir -p "$VOL_PATH/EFI/BOOT"
cp "$EFI_FILE" "$VOL_PATH/EFI/BOOT/BOOTX64.EFI"

echo "--- Ejecting Image ---"
diskutil eject "$DISK_DEV"

echo "--- Starting QEMU ---"
# Your exact QEMU command
qemu-system-x86_64 -bios firmware/built/OVMF.fd -m 16G -vga std -nographic -drive format=raw,file=firmware/built/DISK.img
