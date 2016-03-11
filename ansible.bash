#!/bin/bash
# create a symlink to ansible from your current jobs ansible repository
CURRENT_CUST="~repos/pave"
ANS_LOC="/etc/ansible"

#check for the ansible symlink
if [ ! \( -e "$ANS_LOC" \) ];
  then
  sudo ln -s $CURRENT_CUST/ansible /etc/ansible;
fi
