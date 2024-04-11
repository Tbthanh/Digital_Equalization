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

def equalizer(input_file):
    d = read_wave(input_file)    
    band1 = lowpass(110, d)
    band2 = bandpass(110, 221, d)
    band3 = bandpass(221, 442, d)
    band4 = bandpass(442, 884, d)
    band5 = bandpass(884, 1768, d)
    band6 = bandpass(1768, 3536, d)
    band7 = bandpass(3536, 7071, d)
    band8 = highpass(7071, d)
    signal = band1[0] + band2[0] + band3[0] + band4[0] + band5[0] + band6[0] + band7[0] + band8[0]
    res1 = np.fft.irfft(band1[2])
    f = open("freq_res1", "w")
    for i in res1:
        f.write(str(i)+"\n")
    res2 = np.fft.irfft(band2[2])
    f = open("freq_res2", "w")
    for i in res2:
        f.write(str(i)+"\n")
    res3 = np.fft.irfft(band3[2])
    f = open("freq_res3", "w")
    for i in res3:
        f.write(str(i)+"\n")
    res4 = np.fft.irfft(band4[2])
    f = open("freq_res4", "w")
    for i in res4:
        f.write(str(i)+"\n")
    res5 = np.fft.irfft(band5[2])
    f = open("freq_res5", "w")
    for i in res5:
        f.write(str(i)+"\n")
    res6 = np.fft.irfft(band6[2])
    f = open("freq_res6", "w")
    for i in res6:
        f.write(str(i)+"\n")
    res7 = np.fft.irfft(band7[2])    
    f = open("freq_res7", "w")
    for i in res7:
        f.write(str(i)+"\n")
    res8 = np.fft.irfft(band8[2])    
    f = open("freq_res8", "w")
    for i in res8:
        f.write(str(i)+"\n")
    #plot_t(d[1] , d[0])
    #plot_t(band1[0] , 16000)
    #plot_t(band2[0] , 16000)
    #plot_t(band3[0] , 16000)
    #plot_t(band4[0] , 16000)
    #plot_t(band5[0] , 16000)
    #plot_t(band6[0] , 16000)
    #plot_t(band7[0] , 16000)
    #plot_t(band8[0] , 16000)
    #plot_f(band1[1] , abs(band1[2]))
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

 
awa = equalizer("NGGYU_Chorus.wav")       
write_wave(awa)                                                                                               
#plot_t(awa, 16000)
