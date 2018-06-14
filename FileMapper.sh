#!/bin/bash
#This script tries to get the date via ssh. once it does, it compares it to the pi system date and finds a conversion between the two. 
#Once it does this, it reads in the last line of the Date_To_File.txt and converts the recorded Pi System date to the actual date

# 1st, we ssh into daq to get the date
RealDate=$(ssh -o ConnectTimeout=30 daq@192.168.222.1 "date -u +"%s"") #date in seconds since epoch
PiDate=$(date -u +"%s")
if [[ $RealDate = "" ]]
# If SSH did not work, we cannot do anything with the pi creation date
then 
	TrueCreationDate="SSH__Not__Successful"

else
	Conversion=$((RealDate-PiDate)) #Conversion between Pi time and UTC time
	read PiCreationDate < CURRENT_REPORTS/Dates/CreationTime.txt # Creation date in Pi Time
	TrueCreationDate=$((PiCreationDate+Conversion)) #Converted CreationDate in seconds since epoch
	TrueCreationDate=$(date --date='@'$TrueCreationDate +"%F--%R:%S")


fi

read counter < CURRENT_REPORTS/counter.txt
Num="Report"$[counter-1]
LastLine=$(tail -n1 CURRENT_REPORTS/Dates/Date_To_File.txt)
FileDate=${LastLine:0:20}
FileNum=${LastLine:21}


#  Since this script runs 6 times per hour, it should check to make sure the most recent report has not already been logged
#  $Num is the number of the report currently being written.
#  $FileNum is the report number recorded in the last entry of the Date_To_File Log
#  $TrueCreationDate is the time at which the most recent report was created. $FileDate is the creation time of the last report documented in the log.

if [[ $Num = $FileNum ]]
#If the $Num = $FileNum, the report has already been documented.
#But, we still must check to see if the SSH was working at the time. 
then
	if [[ $FileDate == "SSH__Not__Successful" && $TrueCreationDate != "SSH__Not__Successful" ]]
	then	
		sed -i '$d' CURRENT_REPORTS/Dates/Date_To_File.txt
		echo $TrueCreationDate","$Num >> /home/pi/CURRENT_REPORTS/Dates/Date_To_File.txt
		#In this case, SSH did not work before, but it is now, so the creation date can be obtained. Thus, the last line is replaced 
		#with the correct information

	elif [[ $FileDate == "SSH__Not__Successful" && $TrueCreationDate == "SSH__Not__Successful" ]]
	then
		echo "" > /dev/null
		#SSH failed earlier, and is still not working. Nothing to do
			
	elif [[ $FileDate != "SSH__Not__Successful" && $TrueCreationDate != "SSH__Not__Successful" ]]
	then

		echo "" > /dev/null
		#SSH worked earlier and is still working. Nothing needs to be changed. Note that I do not require the two dates to be the same,
	        #since varying operation times could cause them to differ by a second
			
	elif [[ $FileDate != "SSH__Not__Successful" && $TrueCreationDate == "SSH__Not__Successful" ]]
	then 

		echo "" > /dev/null
		# SSH was sucessful Before, but now it is not working. Do nothing
	fi
else
# $Num != $FileNum. A new report has been generated. write new line to log

	echo $TrueCreationDate","$Num >> /home/pi/CURRENT_REPORTS/Dates/Date_To_File.txt
	

fi






