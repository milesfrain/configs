#!/bin/bash

MOUNT_POINT="/"

# Get initial used space in bytes
initial=$(df --output=used -B1 "$MOUNT_POINT" | tail -1)

echo "Initial used space on $MOUNT_POINT: $(numfmt --to=iec $initial)"
echo "Perform your installations in other terminals."
echo "Press any key to check the disk usage delta..."
read -n 1 -s

# Get new used space in bytes
final=$(df --output=used -B1 "$MOUNT_POINT" | tail -1)
delta=$((final - initial))

echo "Current used space on $MOUNT_POINT: $(numfmt --to=iec $final)"
echo "Disk usage increased by: $(numfmt --to=iec $delta)"
