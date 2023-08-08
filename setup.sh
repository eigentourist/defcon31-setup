#!/bin/bash

# Create working directory and switch to it
mkdir ~/defcon31
cd ~/defcon31

# Update operating system
sudo apt-get update -y

# Install QEMU and related tools
sudo apt-get install -y qemu-system-arm fdisk wget mtools xz-utils

# Download Raspberry Pi OS image
wget https://downloads.raspberrypi.org/raspios_arm64/images/raspios_arm64-2023-05-03/2023-05-03-raspios-bullseye-arm64.img.xz

# Unpack compressed image file
export IMAGE_FILE=2023-05-03-raspios-bullseye-arm64.img
xz -d ${IMAGE_FILE}.xz

# Calculate image file size and resize to next power of two
export CURRENT_SIZE=$(stat -c%s "${IMAGE_FILE}") && \
    NEXT_POWER_OF_TWO=$(python3 -c "import math; \
                                    print(2**(math.ceil(math.log(${CURRENT_SIZE}, 2))))") && \
    qemu-img resize "${IMAGE_FILE}" "${NEXT_POWER_OF_TWO}"


# Extract device tree and kernel files from Raspberry Pi OS image
export OFFSET=$(fdisk -lu ${IMAGE_FILE} | awk '/^Sector size/ {sector_size=$4} /FAT32 \(LBA\)/ {print $2 * sector_size}') && \
    # Check that the offset is not empty
    if [ -z "$OFFSET" ]; then \
        echo "Error: FAT32 not found in disk image" && \
        exit 1; \
    fi && \
    # Setup mtools config to extract files from the partition
    echo "drive x: file=\"${IMAGE_FILE}\" offset=${OFFSET}" > ~/.mtoolsrc
mcopy x:/bcm2710-rpi-3-b-plus.dtb . && \
    mcopy x:/kernel8.img .

mkdir -p /tmp && \
    # First create ssh file to enable ssh
    touch /tmp/ssh && \
    # Then create userconf file to set default password (raspberry)
    echo 'pi:$6$rBoByrWRKMY1EHFy$ho.LISnfm83CLBWBE/yqJ6Lq1TinRlxw/ImMTPcvvMuUfhQYcMmFnpFXUPowjy2br1NA0IACwF9JKugSNuHoe0' | tee /tmp/userconf

mcopy /tmp/ssh x:/ && \
    mcopy /tmp/userconf x:/