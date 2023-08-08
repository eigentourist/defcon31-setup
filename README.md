# Environment setup 
## Hacking The Metal: An Intro to ARM Assembly Language
## A Def Con 31 Workshop
### August 10, 2023


---
### Below are instructions for setting up the environment used to edit, build and run the code in the *defcon31* repository.


1. Download & install VirtualBox (https://www.virtualbox.org/wiki/Downloads)
2. Download Kali VirtualBox (https://cdimage.kali.org/kali-2023.2/kali-linux-2023.2-virtualbox-amd64.7z)
3. Uncompress VM image (you may need 7-zip) add to VirtualBOx, and tune for your machine.
4. Launch VM from VirtualBox
5. Log in as user `kali`, password `kali`
6. Once logged in, launch terminal window and run the following commands. Note: if you get an alert box asking to restart services during package upgrades without asking, just answer Yes and move on.
    1. `sudo apt update`
    2. `sudo apt upgrade -y`
    3. `sudo reboot`
7. Log in after restart (user `kali`, pwd `kali`)
8. Launch terminal window and run the following: `sudo apt-get install –y linux-headers-$(uname -r)`
9. Install VirtualBox Guest Additions Disk (VM Devices Menu > Insert Guest Additions CD Image)
10. Right-click VBox_GAs CD icon in VM desktop, select `Mount Volume`
11. In terminal window, run:
    1. `cp -R /media/kali/VBox_GAs_7.0.8 ~/`
    2. `cd ~/VBox_GAs_7.0.8`
    3. `sudo ./VBoxLinuxAdditions.run`
    4. Type `yes` at `Do you wish to continue?`
    5. `sudo reboot`
12. Log in after restart is complete
13. Open terminal window, and run:
    1. `git clone https://github.com/eigentourist/defcon31-setup.git`
    2. `cd ~/defcon31-setup`
    3. `./setup.sh`