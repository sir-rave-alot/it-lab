
# CLEAN HOME DIRECTORY
rm -rf ${HOME}/Desktop/
rm -rf ${HOME}/Downloads/
rm -rf ${HOME}/Documents/
rm -rf ${HOME}/Pictures/
rm -rf ${HOME}/Public/
rm -rf ${HOME}/Templates/
rm -rf ${HOME}/Videos/

_THE_OUT_FILE="inst-dex.sh"

# GROVEPI INSTALL SCRIPT
curl -kL dexterindustries.com/update_grovepi >> ${_THE_OUT_FILE}
yes | bash ${_THE_OUT_FILE}

# FIRMWARE UPDATE
cd ${HOME}/Dexter/GrovePi/Firmware
yes | bash firmware_update.sh

# CLEAN
rm -rf ${_THE_OUT_FILE}

# CHANGE PASSWORD
echo -e "<_THE_OLD_PW>\n<_THE_NEW_PW>\n<_THE_NEW_PW>" | passwd
