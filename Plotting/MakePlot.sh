#!/bin/bash
sudo rm -r Plots
mkdir Plots
LastLine=$(tail -n1 ../Dates/Date_To_File.txt)
Report=${LastLine:21}".txt"
IFS=''
echo $(tail -300 ../Reports/$Report) > Measurements.csv
python3 Plot.py






