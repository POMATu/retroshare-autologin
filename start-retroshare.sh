#!/bin/bash

source /etc/environment

cd "$(dirname "$0")"

while true
do

perl unlockrs.pl &
nice retroshare
sleep 1
killall -9 retroshare
done

