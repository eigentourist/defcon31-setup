# Environment setup 
## Hacking The Metal: An Intro to ARM Assembly Language
## A Def Con 31 Workshop
### August 10, 2023


---
### Below are instructions for setting up the environment used to edit, build and run the code in the *defcon31* repository. There is also a [Discord server available here.](https://discord.gg/pzAQ3Qhxu)


1. Download & install VirtualBox (https://www.virtualbox.org/wiki/Downloads)
2. Download Kali VirtualBox image (https://cdimage.kali.org/kali-2023.2/kali-linux-2023.2-virtualbox-amd64.7z)
3. Uncompress VM image (you may need 7-zip) add to VirtualBox, and tune for your machine.
4. Launch VM from VirtualBox
5. Log in as user `kali`, password `kali`
6. Once logged in, launch terminal window and run the following commands. Note: if you get an alert box asking to restart services during package upgrades without asking, just answer Yes and move on.
    1. `sudo apt update`
    2. `sudo apt upgrade`
    3. `sudo reboot`
7. Log in after restart (user `kali`, pwd `kali`)
8. Launch terminal window and run the following: `sudo apt-get install linux-headers-$(uname -r)`
9. Install VirtualBox Guest Additions Disk (VM Devices Menu > Insert Guest Additions CD Image)
10. Right-click VBox_GAs CD icon in VM desktop, select `Mount Volume`
11. In terminal window, run:
    1. `cp -R /media/kali/VBox_GAs_7.0.8 ~/` (Note: 7.0.8 may have already changed, so just match the version number you find)
    2. `cd ~/VBox_GAs_7.0.8`
    3. `sudo ./VBoxLinuxAdditions.run`
    4. Type `yes` at `Do you wish to continue?`
    5. `sudo reboot`
12. Log in after restart is complete
13. Open terminal window, and run:
    1. `git clone https://github.com/eigentourist/defcon31-setup.git`
    2. `cd ~/defcon31-setup`
    3. `./setup.sh`
14. The setup script can take some time to run, depending on how many cores and how much memory is given to the VM. Once the script finishes, run `./launch.sh` to launch QEMU and boot up Raspberry Pi OS.
15. A couple of services will likely fail during Raspberry Pi OS startup, specifically those that are trying to check the device's EPROM and serial UART - this is normal, as we don't actually have a physical Raspberry Pi, and QEMU is emulating most, but not quite all, of the Raspberry Pi hardware.
16. Once the login prompt for Raspberry Pi OS appears, open another terminal window and run:
    - `cd ~/defcon31-setup`
    - `./connect.sh`
17. When the login prompt appears in the second terminal window, it should already have the default user `Pi` entered. Type `raspberry` at the password prompt.
18. Raspberry Pi OS will complain about SSH being enabled and the default password for the 'Pi' user not being changed, followed by giving you the shell prompt.
19. At the Raspberry Pi shell prompt, type `git clone https://github.com/eigentourist/defcon31.git`
20. Two of the code examples need the *ncurses* library, so type `sudo apt install libncurses-dev` at the shell prompt.
21. We could use a bit of extra editor functionality, so type `sudo apt install vim` at the shell prompt.
22. When ready to shut down the Raspberry Pi, type `sudo shutdown now -h` at the Raspberry Pi OS shell prompt. This should log you out and start the shutdown process for the QEMU VM. The first terminal window should show the shutdown process and eventually exit back to the Kali Linux shell.

## Some considerations about this setup
- This is a heavier setup than previous Hacking The Metal workshops at Def Con, mainly because we're emulating a non-Intel machine -- the decision to do a setup that is basically a VM within a VM came after a great deal of thought and angst, and it seemed like the best set of tradeoffs available at the current time.
- If you can manage to give the VirtualBox VM 4 processors and 8gb of RAM, your experience will likely be smoother.
- *One* of these programs -- namely, d2a, which is built by running `build-distance2d-asm.sh`, crashes when run. Not to worry, this is deliberate.
