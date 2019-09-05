#!/usr/bin/env bash
#
# REPLACE VARIABLES IN NETWORK CONFIGURATION FILE
# FOR RASPBERRY PI
#
# RAPHAEL ANDONIE, HSLU 2019

################################################################################
VERBOSE=0

OBJ_DIR="output"
TEMPLATE_DIR="templates"
TEMPLATE_PREFIX="template-"
FILENAME="wpa_supplicant.conf"

declare -a KEYS=("<_THE_HOSTNAME>" "<_THE_NW_PASSWORD>")
declare -a VALUES=("pi" "leTm3pass")
################################################################################

_ERR_OK=0
_ERR_FAIL=1

# CHECK IF NOF KEYS AND VALUES MATCH
_NOF_KEYS=${#KEYS[@]}
_NOF_VAL=${#VALUES[@]}

if [ "${_NOF_KEYS}" != "${_NOF_VAL}" ]
then
    echo "Number of Keys and Values mismatch."
fi

# CREATE OUTPUT DIRECTORY IF NOT EXISTING
mkdir -p ${OBJ_DIR}

# TEMPLATE TO WORKING COPY
_CPY_SRC=${TEMPLATE_DIR}/${TEMPLATE_PREFIX}${FILENAME}
_CPY_W=${OBJ_DIR}/${FILENAME}

cp ${_CPY_SRC} ${_CPY_W}

# REPLACE REGULAR EXPRESSIONS
for (( _I=0; _I<${_NOF_KEYS}; _I++ ));
do
  _K=${KEYS[${_I}]}
  _V=${VALUES[${_I}]}
  sed -i -e "s/${_K}/${_V}/g" "${_CPY_W}"
done

exit ${_ERR_OK}


