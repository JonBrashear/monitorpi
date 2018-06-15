#!/bin/bash
# This script generates plots of the last 5 minues of current measurements for all Hall Sensor Channels
sudo rm -r Plots # Clear last set of plots
mkdir Plots #replace with new empty directory
LastLine=$(tail -n1 ../Dates/Date_To_File.txt) #Find latest current report
Report=${LastLine:21}".txt"
IFS=''
F1=$(tail -300 ../Reports/$Report) 
echo $F1 > Measurements.csv #Put last 300 measurements in temporary file
lines=$(wc -l < Measurements.csv)
if [[ $lines -lt 300 ]]
then
	LineBefore=$(tail -n2 ../Dates/Date_To_File.txt)
	DateBefore=${LineBefore:0:14}
	DateNow=${LastLine:0:14}
	HourNow=${DateNow:(-2)}
	HourBefore=$((HourNow-1))
	LastHourDate=${DateNow:0:12}$HourBefore
	if [[ $DateBefore == $LastHourDate ]]
	then
		neededlines=$((300-lines))
		echo $(tail -$neededlines ../Reports/${LineBefore:21}".txt" > Measurements.csv)
		echo $F1 >> Measurements.csv
	fi
fi






# We want generated plots displayed on remote
export DISPLAY=:0 
python3 Plot.py # matplotlib is used to generate plots. 
# Python reads in measurements.csv and plots results






