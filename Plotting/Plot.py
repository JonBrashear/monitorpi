import matplotlib.pyplot as plt
import numpy as np
import os
# We Generate Graphs for All Channels
CH1,CH2,CH3,CH4,CH5,CH6,CH7,CH8,CH9,CH10=np.loadtxt("CURRENT_REPORTS/Plotting/Measurements.csv",delimiter=',',usecols=(0,1,2,3,4,5,6,7,8,9),unpack=True)
Data=[CH1,CH2,CH3,CH4,CH5,CH6,CH7,CH8,CH9,CH10]
l=len(Data[0])
t=0
FREQ=float(os.environ['FREQ'])
inc=1/FREQ
T=[] #Time array
while len(T) < l:
    T.append(t)
    t+=inc

for i in range(0,10):
    # generate plots for all channels
    a=plt.plot(T,Data[i],'ro',markersize=.5)
    plt.xlabel('Time (s)')
    plt.ylabel('Current (A)')
    plt.ylim([8,20])
    string="Graph of Current vs. Time for "+"CH"+str(i+1) 
    #Title of Plot
    plt.title(string)
    name="CURRENT_REPORTS/Plotting/Plots/"+"CH"+str(i+1)+".png"
    plt.savefig(name) 
    # Save to Plots directory
    plt.cla()



