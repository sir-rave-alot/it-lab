#!/usr/bin/env bash
#
# RASPBERRY PI SETUP FILE
#
# THIS SCRIPT IS RUN AND DELETED AT FIRST BOOT OF THE RASPBERRY PI
#
# PLEASE DO NOT APPLY ANY CHANGES THIS FILE
# MAINTAINER CONTACT: RAPHAEL.ANDONIE(AT)HSLU.CH
# LUZERN, 2019
#
################################################################################

_NEW_ADMIN="<_THE_ADMIN>"
_NEW_ADMIN_PW="<_THE_ADMIN_PW>"
_NEW_ADMIN_NAME="<_THE_ADMIN_NAME>"
_NEW_ADMIN_ROOM="<_THE_ADMIN_ROOM>"
_NEW_ADMIN_TEL="<_THE_ADMIN_TEL>"
#
_NEW_USR="<_THE_USR>"
_NEW_USR_PW="<_THE_USR_PW>"
_NEW_USR_NAME="<_THE_USR_NAME>"
_NEW_USR_ROOM="<_THE_USR_ROOM>"
_NEW_USR_TEL="<_THE_USR_TEL>"
#
_OLD_DEF_USR="<_THE_DEFAULT_USR>"

# ADD ADMIN (in group "sudoers")
adduser ${_NEW_ADMIN} --gecos "${_NEW_ADMIN_NAME},${_NEW_ADMIN_ROOM},${_NEW_ADMIN_TEL},${_NEW_ADMIN_TEL}" --disabled-password
echo "${_NEW_ADMIN}:${_NEW_ADMIN_PW}" | sudo chpasswd
usermod -aG sudo ${_NEW_ADMIN}

# ADD USER
adduser ${_NEW_USR} --gecos "${_NEW_USR_NAME},${_NEW_USR_ROOM},${_NEW_USR_TEL},${_NEW_USR_TEL}" --disabled-password
echo "${_NEW_USR}:${_NEW_USR_PW}" | sudo chpasswd

# ALLOW REBOOT AND SHUTDOWN TO NORMAL USER
#echo "## Allow <_THE_USR> reboot and shutdown" >> "/etc/sudoers"
#echo "<_THE_USR> ALL=NOPASSWD: /sbin/reboot, /sbin/shutdown" >> "/etc/sudoers"
echo "shutdown:x:510:<_THE_USR>" >> "/etc/group"
chown root:shutdown /sbin/shutdown
chown root:shutdown /sbin/reboot
chmod 750 /sbin/shutdown
chmod 750 /sbin/reboot
chmod u+s /sbin/shutdown
chmod u+s /sbin/reboot

# DELETE DEFAULT USER (PI)
killall -u ${_OLD_DEF_USR}
userdel -r ${_OLD_DEF_USR}

# EXIT
exit 0