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

_wifi_id=""
_wifi_ssid =""
_wifi_pw =""

_admin=""
_admin_pw=""
_admin_name=""
_admin_room=""
_admin_tel=""

_user=""
_user_pw=""
_user_name=""
_user_room=""
_user_tel=""

_def_usr=""
_def_pw=""

my_env = os.environ.copy()
my_env["PATH"] = "/usr/sbin:/sbin:" + my_env["PATH"]

os.environ["RUN_FROM_PY"] = "1"


def fillTemplates():
  vReplaceRegex(
    "./output/wpa_supplicant.conf",{
    ("<_THE_SSID>",_wifi_ssid),
    ("<_THE_HOSTNAME>",_wifi_id),
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
  vReplaceRegex(
    "./output/rc.local",{
    ("<_THE_SETUPFILE>","/root/setupRPI.sh")
    })
  #
  vReplaceRegex(
    "./output/setupRPI.sh",{
    ("<_THE_ADMIN>",_admin),
    ("<_THE_ADMIN_PW>",_admin_pw),
    ("<_THE_ADMIN_NAME>",_admin_name),
    ("<_THE_ADMIN_ROOM>",_admin_room),
    ("<_THE_ADMIN_TEL>",_admin_tel),
    #
    ("<_THE_USR>",_user),
    ("<_THE_USR_PW>",_user_pw),
    ("<_THE_USR_NAME>",_user_name),
    ("<_THE_USR_ROOM>",_user_room),
    ("<_THE_USR_TEL>",_user_tel),
    #
    ("<_THE_DEFAULT_USR>",_def_usr)
    })
  #
  vReplaceRegex(
    "./output/install-libs.sh",{
    ("<_THE_OLD_PW>",_def_pw),
    ("<_THE_NEW_PW>",_admin_pw),
    ("<_THE_ADMIN>",_admin),
    #
    ("<_THE_DEFAULT_USR>",_def_usr)
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
  global _wifi_id
  global _admin
  global _admin_pw
  global _admin_name
  global _admin_room
  global _admin_tel
  global _user
  global _user_pw
  global _user_name
  global _user_room
  global _user_tel
  global _def_usr
  global _def_pw


  _id = rpi["device"]["id"]
  _hostname =  rpi["device"]["hostname"]
  _type =  rpi["device"]["type"]
  _ip_eth = rpi["device"]["interfaces"]["eth0"]["ip"]
  _nm_eth = rpi["device"]["interfaces"]["eth0"]["nm"]
  _ns_eth = rpi["device"]["interfaces"]["eth0"]["ns"]
  _gw_eth = rpi["device"]["interfaces"]["eth0"]["gw"]
  _wifi_ssid = rpi["device"]["interfaces"]["wlan0"]["ssid"]
  _wifi_pw = rpi["device"]["interfaces"]["wlan0"]["pw"]
  _wifi_id = rpi["device"]["interfaces"]["wlan0"]["idty"]
  _admin = rpi["device"]["admin"]["name"]
  _admin_pw = rpi["device"]["admin"]["pw"]
  _admin_name = rpi["device"]["admin"]["fname"]
  _admin_room = rpi["device"]["admin"]["room"]
  _admin_tel = rpi["device"]["admin"]["tel"]
  _user = rpi["device"]["user"]["name"]
  _user_pw = rpi["device"]["user"]["pw"]
  _user_name = rpi["device"]["user"]["fname"]
  _user_room = rpi["device"]["user"]["room"]
  _user_tel = rpi["device"]["user"]["tel"]
  _def_usr = rpi["device"]["defuser"]
  _def_pw = rpi["device"]["defpw"]

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
  print "login-name   : ", _wifi_id

  print "--ACCOUNTS--"
  print "admin        : ", _admin
  print "admin pw     : ", _admin_pw
  print "user         : ", _user
  print "user pw      : ", _user_pw

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