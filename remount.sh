#!/usr/bin/env bash
#
# Mount Device
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

_PARTITIONS=($(ls ${DISK_ABS_PATH}* | grep ${DISK_ABS_PATH}..))
_MNT_PTS=(${_BOOT_MNT_DIR} ${_RFS_MNT_DIR})

_NOF_PART=${#_PARTITIONS[@]}
_NOF_MNT_PTS=${#_MNT_PTS[@]}

if [ ! "${_NOF_PART}" = "${_NOF_MNT_PTS}" ]; then
  echo "Not as many partitions as expected!"
  exit ${_ERR_FAIL}
fi


for (( i=0; i<${_NOF_PART}; i++ ));
do
  echo ${_PARTITIONS[$i]} "will be mounted at" ${_MNT_PTS[$i]}
  mkdir -p ${_MNT_PTS[$i]}
  mount ${_PARTITIONS[$i]} ${_MNT_PTS[$i]}
done

echo "Done."
exit ${_ERR_OK}