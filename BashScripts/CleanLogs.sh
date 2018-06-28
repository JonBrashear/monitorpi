#!/bin/bash
#If the Pi loses power, file writing operations active at the tiem of shutdown can write null characters to the end of the files they are changing.
#This script runs at reboot and deletes the null characters for log files and the last Current Report generated.

tr < /home/pi/CURRENT_REPORTS/FreqLog.txt -d '\000' > /home/pi/CURRENT_REPORTS/FreqLogM.txt
#The command above creates a copy of FreqLog.txt, but does not copy null characters
mv /home/pi/CURRENT_REPORTS/FreqLogM.txt  /home/pi/CURRENT_REPORTS/FreqLog.txt
#now we must make the entry into FreqLog for the last report, since this is done only when the report is finished
read N < /home/pi/CURRENT_REPORTS/counter.txt
ReportName="Report"$[$N-1]".txt"
read T1 < /home/pi/CURRENT_REPORTS/Dates/CreationTime.txt
cd CURRENT_REPORTS
# find Report, and get its creation time in seconds
T2=$(find -name $ReportName -prune -printf '%Ts')
cd ..
echo $ReportName","$FREQ","$((T2-T1)) >> /home/pi/CURRENT_REPORTS/FreqLog.txt


#Clean Date_To_File.txt of null characters
tr < /home/pi/CURRENT_REPORTS/Dates/Date_To_File.txt -d '\000' > /home/pi/CURRENT_REPORTS/Dates/Date_To_FileM.txt
mv /home/pi/CURRENT_REPORTS/Dates/Date_To_FileM.txt /home/pi/CURRENT_REPORTS/Dates/Date_To_File.txt
#Clean Last Report of null characters
tr < /home/pi/CURRENT_REPORTS/Reports/$ReportName -d '\000' > /home/pi/CURRENT_REPORTS/Reports/"m"$ReportName
mv /home/pi/CURRENT_REPORTS/Reports/"m"$ReportName /home/pi/CURRENT_REPORTS/Reports/$ReportName  

