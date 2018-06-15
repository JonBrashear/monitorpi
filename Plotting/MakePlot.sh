#!/bin/bash
# This script generates plots of the last 5 minues of current measurements for all Hall Sensor Channels
sudo rm -r Plots # Clear last set of plots
mkdir Plots #replace with new empty directory
LastLine=$(tail -n1 ../Dates/Date_To_File.txt) #Find latest current report
Report=${LastLine:21}".txt"
IFS=''
echo $(tail -300 ../Reports/$Report) > Measurements.csv #Put last 300 measurements in temporary file
# We want generated plots displayed on remote
export DISPLAY=:0 
python3 Plot.py # matplotlib is used to generate plots. 
# Python reads in measurements.csv and plots results






