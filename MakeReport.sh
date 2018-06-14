#!/bin/bash
#First, read in counter.txt to assign report name:
echo $(date) > Time.txt
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

#echo "This Log Measures The Voltages Applied to 16 ADC channels" > /home/pi/CURRENT_REPORTS/Reports/$Name".txt"
#echo "The Measurements are taken roughly once per second" >> /home/pi/CURRENT_REPORTS/Reports/$Name".txt"
#echo "|CH00|CH01|CH02|CH03|CH04|CH05|CH06|CH07|CH08|CH09|CH10|CH11|CH12|CH13|CH14|CH15|" >> /home/pi/CURRENT_REPORTS/Reports/$Name".txt"
#echo "---------------------------------------------------------------------------------" >> /home/pi/CURRENT_REPORTS/Reports/$Name".txt"
# Now Take The Actual Measurements
index=0
echo $(date) >>  Time.txt
while [ $index -lt 3600 ]; do
	python3 /home/pi/CURRENT_REPORTS/PythonFiles/GetCurrent.py >> /home/pi/CURRENT_REPORTS/Reports/$Name".txt" &
	let index=index+1
	sleep 1
done
echo $(date) >> Time.txt
mv Time.txt Time1.txt

