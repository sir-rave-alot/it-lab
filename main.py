#!/usr/bin/env python

import json
import sys
from subprocess import Popen
from subprocess import call
from subprocess import PIPE
import os
########################################

SRC_PATH = "."
SRC_FILE = "devices.json"

########################################

_SRC_FILE = SRC_PATH + "/" + SRC_FILE
_PRINT_FRM="~~~~~~~~~~~~~~~~~~~~~~~~~"
_MSG_NOT_IN_PYTHON = "YOU ARE ENTERING BASH!"

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

os.environ["RUN_FROM_PY"] = "1"


def fillTemplates():
  vReplaceRegex(
    "./output/wpa_supplicant.conf",{
    ("<_THE_SSID>",_wifi_ssid),
    ("<_THE_HOSTNAME>",_hostname),
    ("<_THE_NW_PASSWORD>",_wifi_pw)
    })
  #
  vReplaceRegex(
    "./output/hostname",{
    ("<_THE_HOSTNAME>",_hostname)
    })
  #
  vReplaceRegex(
  "./output/hosts",{
  ("<_THE_HOSTNAME>",_hostname)
  })
  #
  vReplaceRegex(
    "./output/dhcpcd.conf",{
    ("<_THE_IP_ADDR>",_ip_eth),
    ("<_THE_NET_MASK>",_nm_eth),
    ("<_THE_DNS_SRV>",_ns_eth),
    ("<_THE_ROUTER>",_gw_eth)
    })
  #



########################################
def makeWorkingCopy():
  print _MSG_NOT_IN_PYTHON
  #p = Popen(['./createWokringCopy.sh','-f','wpa_supplicant.conf'], env=my_env)
  p = Popen(['./copyTemplates.sh'], env=my_env)
  err = p.communicate()
########################################
def config():
  print _MSG_NOT_IN_PYTHON
  p = Popen(['./replaceConfigs.sh'], env=my_env)
  err = p.communicate()
########################################    
def printInputHint():
  print ""
  print ">"
#
#
def vReplaceRegex(file, tuples):
  file_out = "tmp.txt"
  tuples_k = tuples
  tuples_v = tuples

  with open(file, "rt") as fin:
    with open(file_out, "wt") as fout:
      for line in fin:
        curr_line = line
        _iter_keys = map(lambda k: k[0], tuples_k)
        _iter_vals = map(lambda v: v[1], tuples_v)

        for _i in range(0, len(_iter_keys)):
          _kk = _iter_keys[_i] 
          _vv = _iter_vals[_i] 
          temp_line = curr_line.replace(_kk, _vv)
          curr_line = temp_line

        fout.write(temp_line)
      # end for line in fin
  os.rename(file_out, file)
  # end outfile
########################################
#
#
########################################
def burnimage():
  print _MSG_NOT_IN_PYTHON
  p = Popen('./writeImage.sh', stdin=PIPE, env=my_env)
  aw = raw_input()
  p.communicate(aw)
########################################
def cleanAll():
  print _MSG_NOT_IN_PYTHON
  p = Popen('./cleanall.sh', stdin=PIPE, env=my_env)
  aw = raw_input()
  p.communicate(aw)
  #out, err = p.communicate(aw)
  #print 'From subprocess: ' + out
 ########################################
def unmount():
  print _MSG_NOT_IN_PYTHON
  p = Popen('./unmount.sh', stdin=PIPE, env=my_env)
  aw = raw_input()
  p.communicate(aw)
########################################
def remount():
  print _MSG_NOT_IN_PYTHON
  p = Popen('./remount.sh', stdin=PIPE, env=my_env)
  aw = raw_input()
  p.communicate(aw)
########################################
def listLSBLK():
  print _MSG_NOT_IN_PYTHON
  p = Popen('lsblk', stdin=PIPE, env=my_env)
  p.communicate()
########################################
def getDisk():
  print _MSG_NOT_IN_PYTHON
  p = Popen('./unautomount.sh', stdin=PIPE, env=my_env)
  aw = raw_input()
  p.communicate(aw)
########################################
def printHelp():
  print _PRINT_FRM
  print "HELP PAGE"
  print _PRINT_FRM

  print "AUXILIARY"
  print "help    : print this HELP page"
  print "exit    : exit program"
  print ""
  print "PROCESS INFORMATION"
  print "var     : print variables (coming soon)"
  print "detail  : print details of Raspberry Pi"
  print "list    : list disks"
  print ""
  print "PROCESS TRUNK"
  print "get disk: unmount from auto mount done by os"
  print "burn    : burn image"
  print "remount : remount partitions"
  print "parse   : parse 'devices.json'"
  print "copy    : create config files out of templates"
  print "config  : write Configurations"
  print "eject   : unmount filesystem"
  print "clean   : clean all temporary files"

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

print "~ Raspberry Pi Setup ~"
print ""
print "This user frontend is intended as a simple way to use the shell scripts."
print "Anyway, the scripts can also be automated using bash only"
print ""

printHelp()

while True:
  printInputHint()
  usr_in = raw_input()

###
  if(usr_in == "help"):
    printHelp()

  if(usr_in == "exit"):
    sys.exit()

###
  if(usr_in == "detail"):
    printDetails()  

  if(usr_in == "list"):
    listLSBLK()

###
  if(usr_in == "get disk"):
    getDisk()

  if(usr_in == "burn"):
    burnimage()

  if(usr_in == "remount"):
    remount()

  if(usr_in == "parse"):
    parse()
    
  if(usr_in == "copy"):
    makeWorkingCopy()
    fillTemplates()
    
  if(usr_in == "config"):
    config()

  if(usr_in == "eject"):
    unmount()

  if(usr_in == "clean"):
    cleanAll()