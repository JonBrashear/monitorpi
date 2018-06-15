# this script uses piplates library to read the ADC channels
from piplates.DAQCplate import getADC
from time import sleep
def read():
    Currents=[]
    for i in range(0,2):
        for n in range(0,8):
             V=getADC(i,n) #Voltage

             I=(V-.4878)/.1874 #But we want the current measurements
             Currents.append(round(I,3))
    string=''
    for e in Currents:
        string=string+str(e)+","
    
    string=string[0:-1]
    print(string)
read()

