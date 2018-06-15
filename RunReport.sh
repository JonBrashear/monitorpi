#!/bin/bash
# This Script is run when the Pi is turned on or rebooted. It repeatedly runs Makereport.sh, which generates logs of current measurements
sleep 60
l=0
while [ $l -lt 1 ]; do
	. /home/pi/CURRENT_REPORTS/MakeReport.sh
done
