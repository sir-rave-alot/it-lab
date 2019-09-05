#!/usr/bin/env python
# IMAGE FILE PARSER

import json
#from collections import OrderedDict
import sys
########################################

SRC_PATH = "."
SRC_FILE = "devices.json"

########################################

_SRC_FILE = SRC_PATH + "/" + SRC_FILE
_PRINT_FRM="~~~~~~~~~~~~~~~~~~~~~~~~~"


_id =""
_hostname =""
_type =""

_ip_eth =""
_nm_eth =""
_ns_eth =""
_gw_eth =""

_wifi_ssid =""
_wifi_pw =""

print "Raspberry Pi Setup"
########################################
def printInputHint():
  print ""
  print ">"
########################################
def printHelp():
  print _PRINT_FRM
  print "HELP PAGE"
  print _PRINT_FRM

  print "help    : print this HELP page"
  print "exit    : exit program"
  print "var     : define shell variables"
  print "detail  : print details of Raspberry Pi"
  print "list    : list disks"
  print "parse   : parse 'devices.json'"
  print "burn    : burn image"
  print "config  : write Configurations"
  print _PRINT_FRM
########################################
def parse():
  print "Parsing ", _SRC_FILE
  with open(_SRC_FILE, "r+") as json_file:
      rpi = json.load(json_file)

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



