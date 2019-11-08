#!/bin/bash
#
# XPS13 touchpad enable/disable.

ID=$(xinput list | grep DLL.*Touchpad | awk '{print $6}' | awk -F'=' '{print $2}')
STATE=$(xinput list-props $ID | grep 'Device Enabled' | awk '{print $4}')

if [ $STATE -eq 1 ]; then
  xinput disable $ID
else
  xinput enable $ID
fi
