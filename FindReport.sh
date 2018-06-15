#!/bin/bash
# This script can be used to find all current reports created within a apecified hour. 
# It asks the user for a date (precise up to one hour)
echo "Enter The Year, Month. Day, and Hour of the desired report"
echo "Please use this format: 2018/06/05/09 (Year/Month/Day/Hour)"
read Date 
error=true 
# It does some error checking. For example, it checks to se if day, month or hour entries are given as # instead of 0#. 
# It also checks the length of the date string 
while [ $error == true ]; do
	

	if [[ ${Date:6:1} == "/" ]]
	then
		echo ""
		echo "If the Date, Month or Hour is less than 10, make sure to include a leading 0(e.g, 05, not 5)"
		echo "Re-enter Date"
		echo ""
		read Date
	elif [[ ${Date:9:1} == "/" ]]
	then
		echo ""
		echo "If the Date, Month or Hour is less than 10, make sure to include a leading 0(e.g, 05, not 5)"
		echo "Re-enter Date"
		echo ""
		read Date
	elif [[ ${Date:(-2):1} == "/" ]]
	then
		echo ""
		echo "If the Date, Month or Hour is less than 10, make sure to include a leading 0(e.g, 05, not 5)"
		echo "Re-enter Date"
		echo ""
		read Date
	elif  [[ ${#Date} -ne 13 ]]
	then 
		echo ""
		echo "Please use the format specified above"
		echo "Re-enter Date"
		echo ""
		read Date
	else 
		error=false
	fi
done
# Then, the entered date is re-formatted in the style of the entries of the Date_To_File log
TargetDate=${Date:0:4}"-"${Date:5:2}"-"${Date:8:2}"--"${Date:(-2)}
echo $TargetDate > Dates/TargetDate.txt
echo "-----------------------------------------------------------"
# A python script then does a linear search on the Date_To_File Log to find the specified report.
# Note, the search has been tested on a log with 40,000 entries ( > 4 years worth of reports), and still returns an answer in < 5 seconds
python3 PythonFiles/FindReport.py
