#!/bin/bash
l=0
while [ $l -lt 6 ]; do
	. /home/pi/CURRENT_REPORTS/FileMapper.sh
	sleep 540
	let l=l+1
done
