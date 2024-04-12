import math
import numpy as np
import scipy.io.wavfile as wav
import scipy.signal as sps 
import matplotlib.pyplot as plt

def lowpass(fl, fs):
    imp_res = sps.firwin(15, (fl/(fs/2)), window="hamming")
    return imp_res

def bandpass(fl, fh, fs):
    imp_res = sps.firwin(15, [(fl/(fs/2)), (fh/(fs/2))], pass_zero=False, window="hamming")
    return imp_res

def highpass(fh, fs):
    imp_res = sps.firwin(15, fh/(fs/2), pass_zero=False, window="hamming")
    return imp_res

def plot_frequency_response(h, fs):
    w, H = sps.freqz(h, fs=fs)
    plt.figure()
    plt.plot(w, 20 * np.log10(np.abs(H)))
    plt.title('Frequency Response')
    plt.xlabel('Frequency (Hz)')
    plt.ylabel('Magnitude (dB)')
    plt.grid(True)
    plt.show()

def read_wave(input_file):
    data = wav.read(input_file) #data is a tuple 
    return data

def write_wave(data):
    wav.write("output.wav", 16000, data) 

def write_imp_res(data, filename):
    f = open(filename, "w")
    for i in data:
        f.write(str(i)+"\n")

def plot_t(signal, rate):
    t = np.arange(0, 18 * rate)/rate
    plt.figure()
    plt.clf()
    plt.plot(t, signal, label='Signal')
    plt.show()

def fil(data, band):
    o = sps.convolve(data/(2**15), band, "same", "auto")    
    return o   

def write_data(data, filename):
    f = open(filename, "w")
    for i in data:
        f.write(str(i)+"\n") 

def quantize(data):
    a = data*(2**15)
    for i in range (0, len(a), 1):
        a[i] = math.trunc(a[i]) 
    return a

#band1 = lowpass(110, 16000)             #band 1, frequency mode 78Hz
#band2 = bandpass(110, 221, 16000)       #band 2, frequency mode 156Hz
#band3 = bandpass(221, 442, 16000)       #band 3, frequency mode 312Hz
#band4 = bandpass(442, 884, 16000)       #band 4, frequency mode 625Hz
#band5 = bandpass(884, 1768, 16000)      #band 5, frequency mode 1250Hz
#band6 = bandpass(1768, 3536, 16000)     #band 6, frequency mode 2500Hz
#band7 = bandpass(3536, 7071, 16000)     #band 7, frequency mode 5kHz
#band8 = highpass(7071, 16000)           #band 8, frequency mode 10kHz

def equalizer(input_file, gain1 = 0, gain2 = 0, gain3 = 0, gain4 = 0, gain5 = 0, gain6 = 0, gain7 = 0, gain8 = 0):
    d = read_wave(input_file) 

    band1 = lowpass(110, 16000)             #band 1, frequency mode 78Hz
    band2 = bandpass(110, 221, 16000)       #band 2, frequency mode 156Hz
    band3 = bandpass(221, 442, 16000)       #band 3, frequency mode 312Hz
    band4 = bandpass(442, 884, 16000)       #band 4, frequency mode 625Hz
    band5 = bandpass(884, 1768, 16000)      #band 5, frequency mode 1250Hz
    band6 = bandpass(1768, 3536, 16000)     #band 6, frequency mode 2500Hz
    band7 = bandpass(3536, 7071, 16000)     #band 7, frequency mode 5kHz
    band8 = highpass(7071, 16000)           #band 8, frequency mode 10kHz

    band1 = quantize(band1)
    band2 = quantize(band2)
    band3 = quantize(band3)
    band4 = quantize(band4)
    band5 = quantize(band5)
    band6 = quantize(band6)
    band7 = quantize(band7)
    band8 = quantize(band8)

    o1 = fil(d[1], band1/(2**15))
    o2 = fil(d[1], band2/(2**15))
    o3 = fil(d[1], band3/(2**15))
    o4 = fil(d[1], band4/(2**15))
    o5 = fil(d[1], band5/(2**15))
    o6 = fil(d[1], band6/(2**15))
    o7 = fil(d[1], band7/(2**15))
    o8 = fil(d[1], band8/(2**15))

    #plot_t(o1, 16000)   
    #plot_t(o2, 16000)   
    #plot_t(o3, 16000)   
    #plot_t(o4, 16000)   
    #plot_t(o5, 16000)   
    #plot_t(o6, 16000)   
    #plot_t(o7, 16000)   
    #plot_t(o8, 16000) 
   
    write_data(o1, "y1")
    write_data(o2, "y2")
    write_data(o3, "y3")
    write_data(o4, "y4")
    write_data(o5, "y5")
    write_data(o6, "y6")
    write_data(o7, "y7")
    write_data(o8, "y8")

    #plot_frequency_response(band1, 16000)
    #plot_frequency_response(band2, 16000)
    #plot_frequency_response(band3, 16000)
    #plot_frequency_response(band4, 16000)
    #plot_frequency_response(band5, 16000)
    #plot_frequency_response(band6, 16000)
    #plot_frequency_response(band7, 16000)
    #plot_frequency_response(band8, 16000)

    write_imp_res(band1, "imp_res1")
    write_imp_res(band2, "imp_res2")
    write_imp_res(band3, "imp_res3")
    write_imp_res(band4, "imp_res4")
    write_imp_res(band5, "imp_res5")
    write_imp_res(band6, "imp_res6")
    write_imp_res(band7, "imp_res7")
    write_imp_res(band8, "imp_res8")

    signal = o1 + o2 + o3 + o4 + o5 + o6 + o7 + o8
    return signal

equalized = equalizer("NGGYU_Chorus.wav") #input file and 8 gains in dB      
write_wave(equalized)                                                                                               
plot_t(equalized, 16000)