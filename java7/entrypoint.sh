#!/bin/ash

#
# Copyright (c) 2020 Matthew Penner
#
# This repository is licensed under the MIT License.
# https://github.com/matthewpi/images/blob/master/LICENSE.md
#

# Default the TZ environment variable to UTC.
TZ=${TZ:-UTC}
export TZ

# Switch to the container's working directory
cd /home/container

# Set environment variable that holds the Internal Docker IP
export INTERNAL_IP=`ip route get 1 | awk '{print $NF;exit}'`

# Print Java version
java -version

# Replace variables in the startup command
MODIFIED_STARTUP=`eval echo $(echo ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')`
echo "[container@pterodactyl ~]$ ${MODIFIED_STARTUP}"

# Run the startup command
eval ${MODIFIED_STARTUP}