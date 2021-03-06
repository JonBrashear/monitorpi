#!/bin/bash
# This File generates a log of measured currents over a span of ~ 1 hour.
# It assigns each report a unique name based on a counter file.

# First, read in counter.txt to assign report name:
sleep 2
read C < /home/pi/CURRENT_REPORTS/counter.txt 
#The name of the report is then
Name="Report"$C
#We now must increase count by one so the next report has a different name.
echo $[$C+1] > /home/pi/CURRENT_REPORTS/counter.txt
#We Must also mark the Creation Time for the File Mapping System:
echo $(date +"%s") > /home/pi/CURRENT_REPORTS/Dates/CreationTime.txt
#And then Start File Mapping
. /home/pi/CURRENT_REPORTS/BashScripts/RunMapAtReboot.sh&
#Making Report:
touch /home/pi/CURRENT_REPORTS/Reports/$Name".txt"
chmod a+w /home/pi/CURRENT_REPORTS/Reports/$Name".txt"
# Now Take The Actual Measurements
Day=$(date + "%d-%h-%Y")
Day=$(date --date=$Day +"%s")
Hour=$(date +"%H")
EndDate=$((Day+3600*Hour+3600))
function calc { awk "BEGIN {print "$*"}" ;}
SleepTime=$(calc 1/$FREQ)
Date=$(date +"%s")
d1=$Date
while [ $Date -lt $EndDate ]; do
	python3 /home/pi/CURRENT_REPORTS/PythonFiles/GetCurrent.py >> /home/pi/CURRENT_REPORTS/Reports/$Name".txt" &
	sleep $SleepTime
	Date=$(date +"%s")
done
d2=$(calc $Date-$SleepTime)
echo $Name".txt,"$FREQ","$(calc $d2-$d1)  >> /home/pi/CURRENT_REPORTS/FreqLog.txt&
