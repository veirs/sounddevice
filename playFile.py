# play a wav file
import sounddevice as sd
import soundfile as sf

data, fs = sf.read("PinkPanther30_a.wav", dtype = 'float32')
print("sample rate=",fs)
sd.play(data, fs, device = 'hw:0,1')
