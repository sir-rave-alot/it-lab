#!/usr/bin/env bash
#
# REPLACE VARIABLES IN FILE
# FOR RASPBERRY PI
#
# RAPHAEL ANDONIE, HSLU 2019

################################################################################
FILENAME="wpa_supplicant.conf"

declare -a KEYS=("<_THE_SSID>" "<_THE_HOSTNAME>" "<_THE_NW_PASSWORD>")
declare -a VALUES=("anySSID" "anyPi" "anyPass")
################################################################################
# SIMPLE CHECK IF VARIABLE.SH HAS BEEN RUN IN THIS SHELL
if [ -z "${_VAR_IS_RUN}" ];
then
    echo 'Please define Variables.'
    echo 'This is normally done by running variables.sh'
    exit ${_ERR_FAIL}
fi

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

