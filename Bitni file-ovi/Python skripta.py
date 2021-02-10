# -*- coding: utf-8 -*-
"""
Created on Thu Jun  4 00:44:26 2020

@author: Mirko
"""

# -*- coding: utf-8 -*-
"""
Created on Tue Jun  2 16:34:13 2020

@author: Mirko
"""

# -*- coding: utf-8 -*-
"""
Created on Thu Feb 13 14:28:20 2020

@author: juric
"""

import scipy.signal
import numpy as np
import matplotlib.pyplot as plt
peakToPeak = np.load("neuralNet_powerSupplyWaveforms_.npy", allow_pickle=True)
inputData = np.load("neuralNet_inputData_.npy", allow_pickle=True)
# waveform example
listaInputaPoIndexu={}
listaPeakovaMjerenjaPoIndexu={}
index=0
indexTemp=0
for signal in peakToPeak:
    
    arrayPeakovaZaInput=scipy.signal.find_peaks(signal,distance=124)[0]
    for i in range(0,len(arrayPeakovaZaInput)):
        if i not in listaPeakovaMjerenjaPoIndexu :
            listaPeakovaMjerenjaPoIndexu[i]=[]

        listaPeakovaMjerenjaPoIndexu[i].append(signal[arrayPeakovaZaInput[i]])
    indexTemp+=1
plt.figure()
plt.plot(np.linspace(0,1e-7, len(peakToPeak[2])) * 1e9, peakToPeak[2] * 1e3, 'k-')
plt.grid()
plt.xlabel('Vrijeme $t$ [ns]')
plt.ylabel('Napon $v_{cc,int}$ [mV]')
plt.xlim([0, 100])
plt.ylim([-10, 10])


def HammingWeight(no1):
      return bin(no1).count("1")
   
for listaInputa in inputData :
    brojac=0

    for i in range(0,len(listaInputa)):
        if i not in listaInputaPoIndexu:
            listaInputaPoIndexu[i]=[]
        else :
            listaInputaPoIndexu[i].append(listaInputa[i])
        brojac+=1
    

keyHypothesis = np.array([int(_) for _ in range(1,256)])
r_ = []    
t=0 

zaSliku=[]
for index in listaInputaPoIndexu.keys() :
    r_=[]
    for key in keyHypothesis:
                
        results = key * np.array(listaInputaPoIndexu[index])
        HWresults = np.array([HammingWeight(_) for _ in results])
        r_.append(np.corrcoef(HWresults, listaPeakovaMjerenjaPoIndexu[index])[0,1])
    maxx=max(r_)
    minn=min(r_)
    print("w"+str(t))
    l=[]
    br=0
    for x in r_ :  
        if (x==maxx):
            l.append(br)
        br+=1
    for index in l:
        print(format(keyHypothesis[index], '#010b'))
        
    
    t+=1
    
keyy=keyHypothesis[l[0]]
#keyy2=keyHypothesis[l[1]]
#keyy3=keyHypothesis[l[2]]
#print(keyy3)
resultati=[]
for inputi in listaInputaPoIndexu[0]:
    resultati.append(41*inputi)
HWresults = np.array([HammingWeight(_) for _ in resultati])
HWfactor = np.array([HammingWeight(_) for _ in listaInputaPoIndexu[0]])
plt.figure()
plt.scatter(HWresults, np.array(listaPeakovaMjerenjaPoIndexu[0]) * 1e3, marker='.', facecolor='black')
plt.grid()
plt.xlabel('Hammingova težina $h$ []')
plt.ylabel('Napon $v_{cc,int}$ [mVpp]')
plt.legend(['umnožak'])
plt.xlim([0, 15])
plt.ylim([0, 12])

plt.figure()
plt.scatter(HWfactor, np.array(listaPeakovaMjerenjaPoIndexu[0]) * 1e3, marker='.', facecolor='red')
plt.grid()
plt.xlabel('Hammingova težina $h$ []')
plt.ylabel('Napon $v_{cc,int}$ [mVpp]')
plt.legend(['poruka'])
plt.xlim([0, 15])
plt.ylim([0, 12])

plt.figure()
r=plt.scatter(keyHypothesis, r_, color='k', marker='.')
z=plt.plot(keyHypothesis[keyy], maxx, "bo")
plt.grid()
plt.legend(['tražena težina', 'kriva težina'])
plt.xlabel('Hipoteze težine []')
#plt.plot(keyHypothesis[keyy3], maxx, 'bo')

#k=plt.plot(keyHypothesis[keyy2], maxx, 'bo')
plt.ylabel('Pearsonov koef. kor. $r$ []')
plt.xlim([0, 256])
plt.ylim([-0.25, 1.1])
      

