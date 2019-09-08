# HELPER SCRIPTS RASPBERRY PI
Raphael Andonie, HSLU 2019 (See License)
<raphael.andonie@hslu.ch>

## Disclaimer
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

## Hard Dependencies
- bash
- sed
- awk
- grep

## Soft Dependencies
- python 2.7
- libs: json, sys, subprocess, os

## Tutorial
1. Clone the repo using `git clone <url>`
2. Make Scripts executable using `chmod +x run`
3. Create a folder for your image by using `mkdir -p img`
4. Download the image of choice from the download server [Download Page](https://www.raspberrypi.org/downloads/)
5. Extract it and put the *.img file in the "img" folder (`cp *.img img/`)
6. Change the file "variables.sh" for your needs.
7. Run `source variables.sh` to get the common variables defined
8. Run `sudo -E ./run` to enter the interactive interface.

### Examlpe Device Descriptor
Example of the "devices.json" file:
```
{
	"device":{
		"id":"20",
		"hostname":"eee-1",
		"interfaces":{
			"wlan0":{
				"mac":"11:aa:11:aa:11:aa:11",
				"ip":"192.168.2.10",
				"sn":"24",
				"ssid":"tapanuli5GHz",
				"pw":"orangutansarecool2019"	
			},
			"eth0":{
				"mac":"22:bb:22:bb:22:bb:22",
				"ip":"192.168.1.10",
				"nm":"24",
				"ns":"8.8.8.8",
				"gw":"192.168.1.1"	
			}
		},
		"admin":{
			"name":"admin",
			"pw":"bluewhalesarealsocool2019",
			"fname":"teacher",
			"room":"skyhigh-14",
			"tel":"42"
		},
		"user":{
			"name":"stud",
			"pw":"stud2019",
			"fname":"student",
			"room":"everywhere",
			"tel":"247"
		},
		"type":"RPI3B",
		"defuser":"pi"
	}
}
```

## TO DO's
- Add descriptor for templates (until now it's all done in "replaceConfigs.sh") for automatic processing (nicer userinterface)

- Allow multiple users and admins in device descriptor

- 