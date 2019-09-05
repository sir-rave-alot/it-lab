#!/usr/bin/env bash
#
# REPLACE KEYWORDS IN FILE
# FOR RASPBERRY PI
#
# RAPHAEL ANDONIE, HSLU 2019

################################################################################

# Parse for input parameters
while getopts 'f:k:v:' flag; do
  case "${flag}" in
  	f) FILE=${OPTARG} ;;
	k) KEY=${OPTARG} ;;
	v) VAL=${OPTARG} ;;
	*)  ;;
  esac
done

# NO ARGUMENTS PASSED ?
if [ $# -eq 0 ]
then
	echo 'Wrong argument'
	exit ${_ERR_FAIL}
fi


_FULL_FILE_PATH=${PRJ_PATH}/${OBJ_DIR}/${FILE}

sed -i -e "s/${KEY}/${VAL}/g" "${_FULL_FILE_PATH}"

exit ${_ERR_OK}