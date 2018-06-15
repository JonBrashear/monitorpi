#!/bin/bash
# This File generates a log of measured currents over a span of ~ 1 hour.
# It assigns each report a unique name based on a counter file.

# First, read in counter.txt to assign report name:
t1= $(date +'%s')
read C < /home/pi/CURRENT_REPORTS/counter.txt 
#The name of the report is then
Name="Report"$C
#We now must increase count by one so the next report has a different name.
echo $[$C+1] > /home/pi/CURRENT_REPORTS/counter.txt
#We Must also mark the Creation Time for the File Mapping System:
echo $(date +"%s") > /home/pi/CURRENT_REPORTS/Dates/CreationTime.txt
#And then Start File Mapping
. /home/pi/CURRENT_REPORTS/RunMap.sh&
#Making Report:
sudo touch /home/pi/CURRENT_REPORTS/Reports/$Name".txt"
sudo chmod a+w /home/pi/CURRENT_REPORTS/Reports/$Name".txt"
# Now Take The Actual Measurements
index=0
echo $(date) >>  Time.txt
while [ $index -lt 3600 ]; do
	python3 /home/pi/CURRENT_REPORTS/PythonFiles/GetCurrent.py >> /home/pi/CURRENT_REPORTS/Reports/$Name".txt" &
	let index=index+1
	sleep 1
done
t2= $(date +'%s')
echo $((t2-t1)) >> Time.txt

