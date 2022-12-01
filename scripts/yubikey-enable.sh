#!/bin/bash

# http://blog.neptune.mingle.systems/2016/disable-yubikey-with-xinput/

YUBIKEY_ID=$(xinput --list | grep Yubico | perl -lane 'print m/id=(\d+)/g')

xinput set-int-prop $YUBIKEY_ID "Device Enabled" 8 1
sleep 5
xinput set-int-prop $YUBIKEY_ID "Device Enabled" 8 0
