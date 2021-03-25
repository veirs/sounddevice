#!/usr/bin/env python3
"""Pass input directly to output with automatic gain control  
./hydroListen.py -i 'hw:1,0' -o 'hw:1,0' -c 1 -s 48000 -a 0.05 -v 2       # PiSound board in Rpi or  USB sound card inserted
./hydroListen.py -i 'hw:2,0' -o 'hw:2,0' -c 1 -s 48000 -a 0.05 -v 2       hifiberry hat soundboard
See https://www.assembla.com/spaces/portaudio/subversion/source/HEAD/portaudio/trunk/test/patest_wire.c

"""
import argparse
import logging
import numpy as np

def int_or_str(text):
    """Helper function for argument parsing."""
    try:
        return int(text)
    except ValueError:
        return text


parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('-i', '--input-device', type=int_or_str,
                    help='input device ID or substring')
parser.add_argument('-o', '--output-device', type=int_or_str,
                    help='output device ID or substring')
parser.add_argument('-c', '--channels', type=int, default=2,
                    help='number of channels')
parser.add_argument('-t', '--dtype', help='audio data type')
parser.add_argument('-s', '--samplerate', type=float, help='sampling rate')
parser.add_argument('-b', '--blocksize', type=int, help='block size')
parser.add_argument('-l', '--latency', type=float, help='latency in seconds')
parser.add_argument('-v', '--ALC_volume', type=float, help='desired volume ~2 usually')
parser.add_argument('-a', '--averaging',type=float,help='fraction of new data ~0.05 usually')
args = parser.parse_args()
print("args=", args)
aveInput = 1
bufferCnt = 0
frac1 = args.averaging
frac2 = 1.0-frac1

import sounddevice as sd

def callback(indata, outdata, frames, time, status):
    global aveInput, bufferCnt
    if status:
        print("status = ", status)
    volume_norm = np.linalg.norm(indata)
    aveInput = frac2*aveInput + frac1*volume_norm
    gain = args.ALC_volume/aveInput
    bufferCnt += 1
    if bufferCnt % 100 == 0:
        print("Input Volume=",volume_norm, "Average Input=", aveInput, "Gain =", gain)
    
    indata = indata * gain
    outdata[:] = indata

with sd.Stream(device=(args.input_device, args.output_device),
               samplerate=args.samplerate, blocksize=args.blocksize,
               dtype=args.dtype, latency=args.latency,
               channels=args.channels, callback=callback):
    print('#' * 80)
    print('press Return to quit')
    print('#' * 80)
    input()
