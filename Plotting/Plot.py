import matplotlib.pyplot as plt
import numpy as np
# We Generate Graphs for All Channels
[CH0,CH1,CH2,CH3,CH4,CH5,CH6,CH7,CH8,CH9,CH10,CH11,CH12,CH13,CH14,CH15]=np.loadtxt("Measurements.csv",delimiter=',',unpack=True)
Data=[CH0,CH1,CH2,CH3,CH4,CH5,CH6,CH7,CH8,CH9,CH10,CH11,CH12,CH13,CH14,CH15]
l=len(Data[0])
t=0
T=[] #Time array
while t < l:
    T.append(t)
    t+=1

for i in range(0,16):
    # generate plots for all channels
    a=plt.plot(T,Data[i],'ro',markersize=.5)
    plt.xlabel('Time (s)')
    plt.ylabel('Current (A)')
    plt.ylim([8,20])
    string="Graph of Current vs. Time for "+"CH"+str(i) 
    #Title of Plot
    plt.title(string)
    name="Plots/"+"CH"+str(i)+".png"
    plt.savefig(name) 
    # Save to Plots directory
    plt.cla()



