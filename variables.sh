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
export DISK_PATH="/dev/mmcblk0"

###########################
## DEFINE FILE STRUCTURE ##
###########################

# PROJECT ROOT - change to absolute path if needed
export PRJ_PATH="./"

# IMAGE DIRECTORY AND FILE
export IMG_DIR="img"
export IMG_FILE="2018-11-13-raspbian-stretch-lite.img"

# DEFINE FILE STRUCTURE
export TEMPLATE_DIR="templates"
export TEMPLATE_PREFIX="template-"

export OBJ_DIR="output"

################################################################################
######################################
## INTERNAL VARIABLES DO NOT CHANGE ##
######################################
export _IMG_PATH=${IMG_DIR}/${IMG_FILE}


export _ERR_OK=0
export _ERR_FAIL=1

export _VAR_IS_RUN=1