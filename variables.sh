#!/usr/bin/env bash
#
# DEFINE SHELL VARIABLES
# CAUTION: THEY APPLY ONLY TO THE CURRENT SHELL
#
# RAPHAEL ANDONIE, HSLU 2019

################################################################################
# VERBOSITY LEVEL - FUTURE USE
export VERBOSE=0

# YOUR SD-CARD - Find with "lsblk"
export DISK_ABS_PATH="/dev/mmcblk0"

# USER NAMES (OLY ADMIN WILL BE IN SUDOERS)
export ADMIN_USR="admin"
export STUD_USR="stud"

###########################
## DEFINE FILE STRUCTURE ##
###########################

# PROJECT ROOT - change to absolute path if needed
export PRJ_PATH="/home/rave/projects/it-lab"

# IMAGE DIRECTORY AND FILE
export IMG_DIR="img"
export IMG_FILE="2019-04-08-raspbian-stretch.img"

# DEFINE FILE STRUCTURE
export TEMPLATE_DIR="templates"
export TEMPLATE_PREFIX="template-"

# OUTPUT FOR GENERATED TEMPORARY FILES
export OBJ_DIR="output"

# MOUNTPOINTS FOR RPI-LINUX
export BOOT_MNT_DIR="boot"
export RFS_MNT_DIR="rootfs"

################################################################################
######################################
## INTERNAL VARIABLES DO NOT CHANGE ##
######################################
export _IMG_PATH=${PRJ_PATH}/${IMG_DIR}/${IMG_FILE}
export _KEYS_SUFFIX=".keys"

export _OBJ_DIR=${PRJ_PATH}/${OBJ_DIR}
export _TEMPLATE_DIR=${PRJ_PATH}/${TEMPLATE_DIR}

export _BOOT_MNT_DIR=${PRJ_PATH}/${BOOT_MNT_DIR}
export _RFS_MNT_DIR=${PRJ_PATH}/${RFS_MNT_DIR}

export _DEFAULT_USER="pi"
export _DEFAULT_HOST="raspberrypi"
export _DEFAULT_PW="raspberry"


export _ERR_OK=0
export _ERR_FAIL=1

export _VAR_IS_RUN=1