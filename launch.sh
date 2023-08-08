#!/bin/bash

# Launch QEMU to emulate Raspberry Pi 3b
qemu-system-aarch64 -machine raspi3b -cpu cortex-a72 -nographic -dtb ~/defcon31/bcm2710-rpi-3-b-plus.dtb -m 1G -smp 4 -kernel ~/defcon31/kernel8.img -sd ~/defcon31/2023-05-03-raspios-bullseye-arm64.img -append "rw earlyprintk loglevel=8 console=ttyAMA0,115200 dwc_otg.lpm_enable=0 root=/dev/mmcblk0p2 rootdelay=1" -device usb-net,netdev=net0 -netdev user,id=net0,hostfwd=tcp::2222-:22
