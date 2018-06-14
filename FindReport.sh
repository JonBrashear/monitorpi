#!/bin/bash
echo "Enter The Year, Month. Day, and Hour of the desired report"
echo "Please use this format: 2018/06/05/09 (Year/Month/Day/Hour)"
read Date 
error=true 
while [ $error == true ]; do
	

	if [[ ${Date:6:1} == "/" ]]
	then
		echo "If the Date, Month or Hour is less than 10, make sure to include a leading 0(e.g, 05, not 5)"
		echo "Re-enter Date"
		read Date
	elif [[ ${Date:9:1} == "/" ]]
	then
		echo "If the Date, Month or Hour is less than 10, make sure to include a leading 0(e.g, 05, not 5)"
		echo "Re-enter Date"
		read Date
	elif [[ ${Date:(-2):1} == "/" ]]
	then
		echo "If the Date, Month or Hour is less than 10, make sure to include a leading 0(e.g, 05, not 5)"
		echo "Re-enter Date"
		read Date
	elif  [[ ${#Date} -ne 13 ]]
	then 
		echo "Please use the format specified above"
		echo "Re-enter Date"
		read Date
	else 
		error=false
	fi
done
TargetDate=${Date:0:4}"-"${Date:5:2}"-"${Date:8:2}"--"${Date:(-2)}
echo $TargetDate > Dates/TargetDate.txt
python3 PythonFiles/FindReport.py
