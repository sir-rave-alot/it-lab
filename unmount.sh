#!/usr/bin/env bash
#
# Unmount Device
#
# RAPHAEL ANDONIE, HSLU 2019

# Check access rights
if [[ $EUID -ne 0 ]]; then
   echo "Please run as root." 
   exit ${_ERR_FAIL}
fi

# SIMPLE CHECK IF VARIABLE.SH HAS BEEN RUN IN THIS SHELL
if [ -z "${_VAR_IS_RUN}" ];
then
    echo 'Please define Variables.'
    echo 'This is normally done by running variables.sh'
    exit ${_ERR_FAIL}
fi

_MNT_PTS=(${_BOOT_MNT_DIR} ${_RFS_MNT_DIR})
_NOF_MNT_PTS=${#_MNT_PTS[@]}


echo '  ---------------  '
echo '~  UNMOUNT DEVICE  ~'
echo '  ---------------  '
for (( i=0; i<${_NOF_MNT_PTS}; i++ ));
do
  echo -e "\033[31;1munmount: ${_MNT_PTS[$i]}\033[0m"
done
echo ""
read -p "Are you sure? [y,N] " -n 1 -r
echo ' '
if [[ $REPLY =~ ^[Yy]$ ]]
then
    # DANGEROUS STUFF
    echo 'Proceed...'
    for (( i=0; i<${_NOF_MNT_PTS}; i++ ));
    do
      umount ${_MNT_PTS[$i]}
    done
else
  echo 'Aborted.'
  exit ${_ERR_FAIL}
fi

exit ${_ERR_OK}