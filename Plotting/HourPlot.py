#import matplotlib
#matplotlib.use('Qt5Agg')
import matplotlib.pyplot as plt
import numpy as np
import sys


def FreqSearch(Reports,Dur,TargetReport):
    i=0
    Found=0
    for i in range(1,len(Reports)):
        if TargetReport == Reports[i][2:-1]:
            Found=1
            break
        else:
            i+=1

    if Found == 1:
        return Dur[i][2:-1]

    else:
        R=TargetReport+" Not Found"
        return R

def PlotData(Data,Dur,HallSensor):
    if Dur[0] == "R":
        print(Dur)
    else:
        Dur=float(Dur)
        l=len(Data)
        inc=Dur/l
        T=[] #Time array
        t=0
        while len(T) < l:
            T.append(t)
            t+=inc
        a=plt.plot(T,Data,'ro',markersize=.5)
        plt.xlabel('Time (s)')
        plt.ylabel('Current (A)')   
        plt.ylim([8,20])
        string="Graph of Current vs. Time for "+"CH"+str(HallSensor)
        plt.title(string)
        plt.show()

ReportName=sys.argv[1]
HallSensor=int(sys.argv[2])
Reports,Dur=np.loadtxt("/home/pi/CURRENT_REPORTS/FreqLog.txt",dtype=str,delimiter=',',usecols=(0,2),unpack=True)
Dur=FreqSearch(Reports,Dur,ReportName)
CH=np.loadtxt("/home/pi/CURRENT_REPORTS/Reports/"+ReportName,delimiter=',',usecols=(HallSensor-1),unpack=True)
PlotData(CH,Dur,HallSensor)

