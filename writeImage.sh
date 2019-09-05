#!/usr/bin/env bash
#
# CREATE BOOTABLE DEVICE
#
# RAPHAEL ANDONIE, HSLU 2019

################################################################################

# Check access rights
if [[ $EUID -ne 0 ]]; then
   echo "Please run as root." 
   exit ${_ERR_FAIL}
fi

# DEFAULT BLOCK SIZE
_BS='4M'

# Parse for input parameters
while getopts 'v:i:b:' flag; do
  case "${flag}" in
	v) DISK_ABS_PATH=${OPTARG} ;;
	i) _IMG_PATH=${OPTARG} ;;
	b) _BS=${OPTARG} ;;
	*)  ;;
  esac
done

echo '  ---------------  '
echo '~ SETUP RASPBERRY ~'
echo '  ---------------  '
echo -e "\033[31;1mUSB-DEVICE: ${DISK_ABS_PATH}\033[0m"
echo 'IMAGE: '${_IMG_PATH}
echo 'BLOCK SIZE: '${_BS}
echo ""
read -p "Are you sure? [y,N] " -n 1 -r
echo ' '
if [[ $REPLY =~ ^[Yy]$ ]]
then
    # DANGEROUS STUFF
    echo 'Proceed...'
    umount ${DISK_ABS_PATH}?*
    dd bs=${_BS} if=${_IMG_PATH} of=${DISK_ABS_PATH} status=progress conv=fsync
else
	echo 'Aborted.'
	exit ${_ERR_FAIL}
fi

exit ${_ERR_OK}