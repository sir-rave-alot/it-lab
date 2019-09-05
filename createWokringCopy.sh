#!/usr/bin/env bash
#
# REPLACE KEYWORDS IN FILE
# FOR RASPBERRY PI
#
# RAPHAEL ANDONIE, HSLU 2019

################################################################################

# Parse for input parameters
while getopts 'f:' flag; do
  case "${flag}" in
	f) FILENAME=${OPTARG} ;;
	*)  ;;
  esac
done

# NO ARGUMENTS PASSED ?
if [ $# -eq 0 ]
then
	echo 'Wrong argument'
	exit ${_ERR_FAIL}
fi

################################################################################
# SIMPLE CHECK IF VARIABLE.SH HAS BEEN RUN IN THIS SHELL
if [ -z "${_VAR_IS_RUN}" ];
then
    echo 'Please define Variables.'
    echo 'This is normally done by running variables.sh'
    exit ${_ERR_FAIL}
fi

# CREATE OUTPUT DIRECTORY IF NOT EXISTING
mkdir -p ${OBJ_DIR}

# TEMPLATE TO WORKING COPY
_CPY_SRC=${PRJ_PATH}/${TEMPLATE_DIR}/${TEMPLATE_PREFIX}${FILENAME}
_CPY_W=${PRJ_PATH}/${OBJ_DIR}/${FILENAME}

cp ${_CPY_SRC} ${_CPY_W}

exit ${_ERR_OK}


