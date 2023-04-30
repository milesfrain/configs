#!/bin/bash

# If any argument is supplied, it will skip to immediate disabling

# http://blog.neptune.mingle.systems/2016/disable-yubikey-with-xinput/

YUBIKEY_ID=$(xinput --list | grep Yubico | perl -lane 'print m/id=(\d+)/g')

# Only enable if no arguments are supplied
if [ -z "$1" ]
  then
    echo enabling yubikey for 5 seconds
    xinput set-int-prop $YUBIKEY_ID "Device Enabled" 8 1
    sleep 5
fi

xinput set-int-prop $YUBIKEY_ID "Device Enabled" 8 0
echo yubikey disabled
