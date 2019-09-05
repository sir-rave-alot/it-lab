
# BLOCK SIZE
_BS='4M'


echo '  ---------------  '
echo '~ SETUP RASPBERRY ~'
echo '  ---------------  '
echo -e "\033[31;1mUSB-DEVICE: ${DISK_ABS_PATH}\033[0m"
echo 'IMAGE: '${_IMG_PATH}
echo 'BLOCK SIZE: '${_BS}
echo ""
read -p "Are you sure? [y,N] " -n 1 -r
echo ' '
if [[ $REPLY =~ ^[Yy]$ ]]
then
    # DANGEROUS STUFF
    echo 'Proceed...'
    umount ${DISK_ABS_PATH}?*
    #dd bs=${_BS} if=${_IMG_PATH} of=${DISK_ABS_PATH} status=progress conv=fsync
else
	echo 'Aborted.'
	exit ${_ERR_FAIL}
fi

exit ${_ERR_OK}