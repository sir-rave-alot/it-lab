#!/usr/bin/env bash
#
# WRITE CONFIGS TO RPI
#
# RAPHAEL ANDONIE, HSLU 2019

################################################################################

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

# HOSTNAME
cp ${PRJ_PATH}/${OBJ_DIR}/"hostname" ${_RFS_MNT_DIR}/"hostname"
cp ${PRJ_PATH}/${OBJ_DIR}/"hosts" ${_RFS_MNT_DIR}/"hosts"

# SSH SERVER ENABLE
touch ${_BOOT_MNT_DIR}"/ssh"

# WIFI CONFIGURATION
cp ${PRJ_PATH}/${OBJ_DIR}/"wpa_supplicant.conf" ${_BOOT_MNT_DIR}/"wpa_supplicant.conf"

# STATIC IP ETH0
cp ${PRJ_PATH}/${OBJ_DIR}/"dhcpcd.conf" ${_RFS_MNT_DIR}/"etc/dhcpcd.conf"

# (SSH-KEY)

# USER DIRECTORIES
# mkdir -p ${_BOOT_MNT_DIR}/"home"/${ADMIN_USR}
# mkdir -p ${_BOOT_MNT_DIR}/"home"/${STUD_USR}

# .BASHRC
# cp ${PRJ_PATH}/${OBJ_DIR}/".bashrc" ${_BOOT_MNT_DIR}/"home"/${STUD_USR}/".bashrc"

# INIT SCRIPT
cp ${PRJ_PATH}/${OBJ_DIR}/"setupRPI.sh" ${_RFS_MNT_DIR}/"home"/${_DEFAULT_USER}

