#!/bin/bash

# variables
PKG_TO_INSTALL="apache2 bind9 bind9utils bind9-doc"
NR_OF_PKG = "4"
ADJUST_BIND9="OPTIONS=”-4 -u bind”"

# See if script is running as root
if [ "$(id -u)" -ne 0 ]; then

echo 'This script must be run by root'
echo "Stopping the script ..."
exit 1
fi

# update and install packages
echo "Updating..."
apt-get update  # To get the latest package lists
echo "Updating complete! Upgrading..."
apt-get upgrade
echo "Upgrade complete! Installing ${NR_OF_PKG} packages"
apt-get install ${PKG_TO_INSTALL} -y
echo "Installing packages complete!"

# adjust /etc/default/bind9
echo "Creating backup file for bind9"

CMD_BAK_BIND9="cp /etc/default/bind9 /etc/default/bind9.bak"
eval $CMD_BAK_BIND9
echo "Backup complete"

echo "#\n# run resolv.conf?\nRESOLVCONF=no\n\n# startup options for the server\nOPTIONS=${ADJUST_BIND9}" > /etc/default/bind9
echo "  - Edited the bind9 file"

# adjust /etc/bind/named.conf.local 

echo "Creating backup file for named.conf.local"

CMD_BAK_NAMED="cp /etc/bind/named.conf.local /etc/bind/named.conf.local.bak"
eval $CMD_BAK_NAMED

echo "Backup complete"

echo "Adding lines to named.conf.local"

echo 'zone " mctinternal.be" {' >> /etc/bind/named.conf.local
echo "      type master;" >> /etc/bind/named.conf.local
echo '      file "/etc/bind/zones/ mctinternal.be";' >> /etc/bind/named.conf.local
echo "};" >> /etc/bind/named.conf.local

echo "" >> /etc/bind/named.conf.local

echo 'zone "X.168.192.in-addr.arpa" {' >> /etc/bind/named.conf.local
echo "      type master;" >> /etc/bind/named.conf.local
echo '     file "/etc/bind/zones/reverse/rev.X.168.192";' >> /etc/bind/named.conf.local
echo "};" >> /etc/bind/named.conf.local

# create zone directory

echo "Creating /etc/bind/zones/reverse"
CMD_MKDIR_ZONES="mkdir -p /etc/bind/zones/reverse"
eval $CMD_MKDIR_ZONES
echo "Done creating directory"

echo "Creating file in /etc/bind/zones"
CMD_TOUCH_NMCT = "touch /etc/bind/zones/nmctinternal.be"
eval $CMD_TOUCH_NMCT
echo "Done creating file"
