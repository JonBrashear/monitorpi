#This Script asks the user for an hour in a day and returns all Current Reports started in that hour
import numpy as np
def LinSearch(TD,Times,Reports):
    RL=[]
    n=0
    for line in Times:      
        if line[2:16] == TD:
            RL.append(line[2:22]+": "+Reports[n][2:-1])
        n+=1
    if RL == []:
        print("\nNo Entries found. The System was either off, or did not have an SSH connection to a good clock")
    else:
        print("\nThe reports below were created in the specified hour: ")
        for e in RL:
            print(e)


CreationTimes,Reports=np.loadtxt('/home/pi/CURRENT_REPORTS/Dates/Date_To_File.txt',dtype=str, delimiter=',',skiprows=1, usecols=(0,1),unpack=True)
f=open('Dates/TargetDate.txt')
TargetDate=f.read()
f.close()
LinSearch(TargetDate[0:14],CreationTimes,Reports)

