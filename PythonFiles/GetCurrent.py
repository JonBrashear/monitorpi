from piplates.DAQCplate import getADC
from time import sleep
def read():
    Currents=[]
    for i in range(0,2):
        for n in range(0,8):
             V=getADC(i,n)
             I=(V-.4878)/.1874
             Currents.append(round(I,3))
    string=''
    for e in Currents:
        string=string+str(e)+","
    
    string=string[0:-1]
    print(string)
read()

