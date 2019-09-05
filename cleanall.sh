#!/usr/bin/env bash
#
# CLEAN ALL
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

echo '  ---------------  '
echo '~      CLEAN      ~'
echo '  ---------------  '
echo -e "\033[31;1mDefinitively Remove: ${_OBJ_DIR}\033[0m"
echo ""


if [ ! -z "$RUN_FROM_PY" ];
then
  echo "Are you sure? [y,N] " 
fi
read -p "Are you sure? [y,N] " -n 1 -r
echo ' '
if [[ $REPLY =~ ^[Yy]$ ]]
then
    # DANGEROUS STUFF
    echo 'Proceed...'
    rm -r ${_OBJ_DIR}
else
  echo 'Aborted.'
  exit ${_ERR_FAIL}
fi

exit ${_ERR_OK}

OBJ_DIR