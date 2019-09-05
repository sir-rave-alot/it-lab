# HELPER SCRIPTS RASPBERRY PI
Raphael Andonie, HSLU 2019 (See License)
<raphael.andonie@hslu.ch>

# Disclaimer
NO WARRANTY. THE USER IS RESPONSIBLE FOR ANY DAMAGE.

This project is far from perfect. It has been created for a very specifc use and has been "haereklepft", as one says in bernese German.
But maybe it inspirates YOU to build up such a system and share it with us!

## Description
This repo consists of a collection of shell scripts which should help to automate tedious tasks concerning the setup of a large number of Raspberry Pi.
There is a Python frontend for better usage. Nevertheless this script is just calling the *.sh scripts, so it is also possible to do all with plain shell and without a python install.

### Functions (in progress)
1. Create bootable devie (Micro SD card)
2. Automatically get MAC-Adress of the RPi
3. Put files into the root file system of the RPi

## Dependencies
- bash
- sed

## Tutorial
1. Clone the repo using `git clone <url>`
2. Make Scripts executable using `chmod +x *.sh`
3. Change the file "variables.sh" for your needs.
4. Run `source variables.sh` to get the common variables defined
5. Run `sudo -E ./run` to enter the interactive interface.
