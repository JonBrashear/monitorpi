#!/bin/bash
#Runs FileMapper.sh 6 times per hour
sleep 5
l=0
while [ $l -lt 6 ]; do
	. /home/pi/CURRENT_REPORTS/BashScripts/FileMapper.sh
	sleep 540
	let l=l+1
done
