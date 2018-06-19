# This Script reads the date written to TargetDate.txt and performs a linear search on Date_To_File.txt to find reports written in the hour.
# It is run by FindReport.sh
import numpy as np
def LinSearch(TD,Times,Reports):
    # TD is TargetDate, Times is List of Creation Times, Reports is List of Report Numbers
    RL=[]
    n=0
    a=0
    for line in Times:  
        # line[2:16] is the Date corresponding to the nth entry
        if line[2:16] == TD:
            # If this date matches the target Date, add it, and the corresponding report to list of reports that match target date
            RL.append(line[2:22]+": "+Reports[n][2:-1]+".txt")
            if a == 0:
                n_minus1=n-1
                a=1
        n+=1
    if RL == []:
        # if the list of reports was empty, nothing matched the target date
        print("No Entries found. The System was either off, or did not have an SSH connection to a good clock")
        print("Try searching for reports created one hour earlier to get an idea of the desired report number")
    else:
        print("The reports below were created in the specified hour: ")
        for e in RL:
            print(e)
        #It is also possible that the a file created 1 hour earlier has measurements from the desired hour. 
        #Information about the report created immeadiately before the 1st report created in the target hour is thus displayed as well
        LastReport=Reports[n_minus1][2:-1]
        if LastReport != "Report#": 
            print("\nThe time/title of the report created immediately before this/these report(s) is also displayed below")
            print("It may contain measurements from the desired hour")
            print(Times[n_minus1][2:22]+": "+LastReport+".txt")

# Read in lists of file creation times and corresponding report numbers from Date_To_File.txt log
CreationTimes,Reports=np.loadtxt('/home/pi/CURRENT_REPORTS/Dates/Date_To_File.txt',dtype=str,comments='%',delimiter=',', usecols=(0,1),unpack=True)
# next, read in target date
f=open('Dates/TargetDate.txt')
TargetDate=f.read()
f.close()
# run linear search to find reports
LinSearch(TargetDate[0:14],CreationTimes,Reports)

