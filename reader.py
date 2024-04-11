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
    b, a = sps.butter(5, [low_ratio, high_ratio], btype='bandpass', output="ba")
    w, h = sps.freqz(b, a, fs=16000, worN=8000)
    y = sps.lfilter(b, a, data[1]/(2**15))
    return (y,w,h)

def lowpass(low_end, data):
    low_ratio = low_end/(data[0]*0.5)
    b, a = sps.butter(5, low_ratio, btype='lowpass', output="ba")
    w, h = sps.freqz(b, a, fs=16000, worN=8000)
    y = sps.lfilter(b, a, data[1]/(2**15))
    return (y,w,h)

def highpass(high_end, data):
    high_ratio = high_end/(data[0]*0.5)
    b, a = sps.butter(5, high_ratio, btype='highpass', output="ba")
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

def gain(data, g):
    data *= 10**(g/10)
    return data

def write_freq_res(data, filename):
    f = open(filename, "w")
    for i in data:
        f.write(str(i)+"\n")

def equalizer(input_file, gain1 = 0, gain2 = 0, gain3 = 0, gain4 = 0, gain5 = 0, gain6 = 0, gain7 = 0, gain8 = 0):
    d = read_wave(input_file) 

    band1 = lowpass(110, d)         #band 1, frequency mode 78Hz
    band2 = bandpass(110, 221, d)   #band 2, frequency mode 156Hz
    band3 = bandpass(221, 442, d)   #band 3, frequency mode 312Hz
    band4 = bandpass(442, 884, d)   #band 4, frequency mode 625Hz
    band5 = bandpass(884, 1768, d)  #band 5, frequency mode 1250Hz
    band6 = bandpass(1768, 3536, d) #band 6, frequency mode 2500Hz
    band7 = bandpass(3536, 7071, d) #band 7, frequency mode 5kHz
    band8 = highpass(7071, d)       #band 8, frequency mode 10kHz

    out1 = gain(band1[0],gain1)     #band i gain, i = 1->8
    out2 = gain(band2[0],gain2)     
    out3 = gain(band3[0],gain3)     
    out4 = gain(band4[0],gain4)     
    out5 = gain(band5[0],gain5)     
    out6 = gain(band6[0],gain6)     
    out7 = gain(band7[0],gain7)     
    out8 = gain(band8[0],gain8)     

    signal = out1 + out2 + out3 + out4 + out5 + out6 + out7 + out8 #merge signals

    res1 = np.fft.irfft(band1[2])   #band i inverse fast fourier transform 
    res2 = np.fft.irfft(band2[2])   #converts frequency response from complex in frequency region to real in time region
    res3 = np.fft.irfft(band3[2])   #i = 1->8
    res4 = np.fft.irfft(band4[2])
    res5 = np.fft.irfft(band5[2])
    res6 = np.fft.irfft(band6[2])
    res7 = np.fft.irfft(band7[2])    
    res8 = np.fft.irfft(band8[2])    

    write_freq_res(res1, "freq_res1") #write to file
    write_freq_res(res2, "freq_res2")
    write_freq_res(res3, "freq_res3")
    write_freq_res(res4, "freq_res4")
    write_freq_res(res5, "freq_res5")
    write_freq_res(res6, "freq_res6")
    write_freq_res(res7, "freq_res7")
    write_freq_res(res8, "freq_res8")

    #f = open("wave_file","w")
    #for i in band1[0]:
    #    f.write(str(i)+"\n")
    #plot_t(d[1] , d[0])
    #plot_t(band1[0] , 16000)   #plot signal over time
    #plot_t(band2[0] , 16000)
    #plot_t(band3[0] , 16000)
    #plot_t(band4[0] , 16000)
    #plot_t(band5[0] , 16000)
    #plot_t(band6[0] , 16000)
    #plot_t(band7[0] , 16000)
    #plot_t(band8[0] , 16000)
    #plot_f(band1[1] , abs(band1[2]))   #plot frequency response over frequency
    #plot_f(band2[1] , abs(band2[2]))
    #plot_f(band3[1] , abs(band3[2]))
    #plot_f(band4[1] , abs(band4[2]))
    #plot_f(band5[1] , abs(band5[2]))
    #plot_f(band6[1] , abs(band6[2]))
    #plot_f(band7[1] , abs(band7[2]))
    #plot_f(band8[1] , abs(band8[2]))
    #plot_t(res1 , 16000)
    #plot_t(res2 , 16000)
    #plot_t(res3 , 16000)
    #plot_t(res4 , 16000)
    #plot_t(res5 , 16000)
    #plot_t(res6 , 16000)
    #plot_t(res7 , 16000)
    #plot_t(res8 , 16000)
    return signal

 
equalized = equalizer("NGGYU_Chorus.wav",15,15,15,10,10,10,10,10) #input file and 8 gains in dB      
write_wave(equalized)                                                                                               
plot_t(equalized, 16000)
