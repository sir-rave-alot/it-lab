#!/usr/bin/env python

import json
import sys
from subprocess import Popen
from subprocess import call
import os
########################################

SRC_PATH = "."
SRC_FILE = "devices.json"

########################################

_SRC_FILE = SRC_PATH + "/" + SRC_FILE
_PRINT_FRM="~~~~~~~~~~~~~~~~~~~~~~~~~"
_MSG_NOT_IN_PYTHON = "YOU ARE ENTERING ANOTHER SHELL!"

_id =""
_hostname =""
_type =""

_ip_eth =""
_nm_eth =""
_ns_eth =""
_gw_eth =""

_wifi_ssid =""
_wifi_pw =""

my_env = os.environ.copy()
my_env["PATH"] = "/usr/sbin:/sbin:" + my_env["PATH"]


print "Raspberry Pi Setup"
########################################
def printInputHint():
  print ""
  print ">"
########################################
def burnimage():
  print _MSG_NOT_IN_PYTHON
  Process=Popen('./writeImage.sh', env=my_env)
########################################
def makeWorkingCopy():
  print _MSG_NOT_IN_PYTHON
  #Process=Popen('./createWokringCopy.sh', '-f', 'wpa_supplicant.conf', env=my_env)
  #call(['./createWokringCopy','-f','wpa_supplicant.conf'])
  Popen(['./createWokringCopy.sh','-f','wpa_supplicant.conf'], env=my_env)
########################################
def cleanAll():
  print ""
########################################
def printHelp():
  print _PRINT_FRM
  print "HELP PAGE"
  print _PRINT_FRM

  print "help    : print this HELP page"
  print "exit    : exit program"
  print "clean   : clean all temporary files"
  print "var     : define shell variables"
  print "detail  : print details of Raspberry Pi"
  print "list    : list disks"
  print "parse   : parse 'devices.json'"
  print "burn    : burn image"
  print "copy    : create config files out of templates"
  print "config  : write Configurations"
  print _PRINT_FRM
########################################
def parse():
  print "Parsing ", _SRC_FILE
  with open(_SRC_FILE, "r+") as json_file:
      rpi = json.load(json_file)

  global _id
  global _hostname
  global _type
  global _ip_eth
  global _nm_eth
  global _ns_eth
  global _gw_eth
  global _wifi_ssid
  global _wifi_pw

  _id = rpi["device"]["id"]
  _hostname =  rpi["device"]["hostname"]
  _type =  rpi["device"]["type"]
  _ip_eth = rpi["device"]["interfaces"]["eth0"]["ip"]
  _nm_eth = rpi["device"]["interfaces"]["eth0"]["nm"]
  _ns_eth = rpi["device"]["interfaces"]["eth0"]["ns"]
  _gw_eth = rpi["device"]["interfaces"]["eth0"]["gw"]
  _wifi_ssid = rpi["device"]["interfaces"]["wlan0"]["ssid"]
  _wifi_pw = rpi["device"]["interfaces"]["wlan0"]["pw"]

  print "Done"
########################################
def printDetails():
  print "--GENERAL--"
  print "Device ID    : ", _id 
  print "Host Name    : ", _hostname
  print "Model        : ", _type

  print "--ETHERNET--"
  print "IP-Addr      : ", _ip_eth
  print "Netmask Bits : ", _nm_eth
  print "DNS Server   : ", _ns_eth
  print "Default GW   : ", _gw_eth

  print "--WIFI--"
  print "ssid         : ", _wifi_ssid
  print "password     : ", _wifi_pw
########################################

printHelp()

while True:
  printInputHint()
  usr_in = raw_input()

  if(usr_in == "help"):
    printHelp()

  if(usr_in == "exit"):
    sys.exit()

  if(usr_in == "parse"):
    parse()

  if(usr_in == "detail"):
    printDetails()

  if(usr_in == "burn"):
    burnimage()
    
  if(usr_in == "copy"):
    makeWorkingCopy()
    