import math
import numpy as np
import scipy.io.wavfile as wav
import scipy.signal as sps 
import matplotlib.pyplot as plt

def read_wave(input_file):
    data = wav.read(input_file) #data is a tuple 
    return data

def write_wave(data):
    wav.write("output.wav", 16000, data) 
    #wav.write("output.wav", data[0], data[1]) 

def bandpass(low_end, high_end, data):
    low_ratio = low_end/(data[0]*0.5)
    high_ratio = high_end/(data[0]*0.5)
    b, a = sps.butter(2, [low_ratio, high_ratio], btype='bandpass', output="ba")
    w, h = sps.freqz(b, a, fs=16000, worN=8000)
    y = sps.lfilter(b, a, data[1]/(2**15))
    return (y,w,h)

def plot_t(signal, rate):
    t = np.arange(0, 18 * rate)/rate
    plt.figure(1)
    plt.clf()
    plt.plot(t, signal, label='Signal')
    plt.show()
    plt.close()

def plot_f(w, h):
    plt.figure(2)
    plt.clf()
    plt.plot(w, abs(h), label="Frequency Response")
    plt.xlabel('Frequency (Hz)')
    plt.ylabel('Gain')
    plt.grid(True)
    plt.legend(loc='best')
    plt.show()
    plt.close()

d = read_wave("NGGYU_Chorus.wav")
band1 = bandpass(30, 61, d)
band2 = bandpass(62, 124, d)
band3 = bandpass(125, 249, d)
band4 = bandpass(250, 499, d)
band5 = bandpass(500, 999, d)
band6 = bandpass(1000, 1999, d)
band7 = bandpass(2000, 3999, d)
band8 = bandpass(4000, 7999, d)
write_wave(band1[0])
#do = read_wave("output.wav")
#plot_t(d[1] , d[0])
#plot_t(e[0] , 16000)
#plot_f(e[1] , abs(e[2]))
