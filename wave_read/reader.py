import wave
import numpy as np
import scipy.io.wavfile as wav
import struct
import scipy.signal as sps 
def read_wave(input_file):
    data = wav.read(input_file)
    return data
def write_wave(data):
    wav.write("output.wav", data[0], data[1])
write_wave(read_wave("NGGYU_Chorus.wav"))