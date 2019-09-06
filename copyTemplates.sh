#!/usr/bin/env bash
#
# REPLACE KEYWORDS IN FILE
# FOR RASPBERRY PI
#
# RAPHAEL ANDONIE, HSLU 2019

################################################################################
# SIMPLE CHECK IF VARIABLE.SH HAS BEEN RUN IN THIS SHELL
if [ -z "${_VAR_IS_RUN}" ];
then
    echo 'Please define Variables.'
    echo 'This is normally done by running variables.sh'
    exit ${_ERR_FAIL}
fi

# CREATE OUTPUT DIRECTORY IF NOT EXISTING
mkdir -p ${_OBJ_DIR}

# COPY TEMPLATE DIRECTORY FILES
_TEMPLATES=($(ls ${_TEMPLATE_DIR}))
_NOF_TPL=${#_TEMPLATES[@]}

for (( i=0; i<${_NOF_TPL}; i++ ));
do
	_CPY_SRC=${_TEMPLATE_DIR}/${_TEMPLATES[$i]}
	_CPY_DEST=${_OBJ_DIR}/${_TEMPLATES[$i]#"$TEMPLATE_PREFIX"}
	cp ${_CPY_SRC} ${_CPY_DEST}
done

exit 0
# TEMPLATE TO WORKING COPY
_CPY_SRC=${PRJ_PATH}/${TEMPLATE_DIR}/${TEMPLATE_PREFIX}${FILENAME}
_CPY_W=${PRJ_PATH}/${OBJ_DIR}/${FILENAME}

cp ${_CPY_SRC} ${_CPY_W}

echo "Template ${_CPY_SRC} copied to ${_CPY_W}"
exit ${_ERR_OK}


