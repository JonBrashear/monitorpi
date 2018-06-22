#!/bin/bash
# This script generates plots of the last 5 minues of current measurements for all Hall Sensor Channels
sudo rm -r /home/pi/CURRENT_REPORTS/Plotting/Plots # Clear last set of plots
mkdir /home/pi/CURRENT_REPORTS/Plotting/Plots #replace with new empty directory
LastLine=$(tail -n1 CURRENT_REPORTS/Dates/Date_To_File.txt) #Find latest current report
Report=${LastLine:21}".txt"
IFS=''
function calc { awk "BEGIN { print "$*" }";}
numLines=$(calc 300*$FREQ) 
echo $(tail -$numLines CURRENT_REPORTS/Reports/$Report) > /home/pi/CURRENT_REPORTS/Plotting/Measurements.csv #Put last 300 measurements in temporary file
# We want generated plots displayed on remote
export DISPLAY=:0 
python3 CURRENT_REPORTS/Plotting/Plot.py # matplotlib is used to generate plots. 
# Python reads in measurements.csv and plots results






