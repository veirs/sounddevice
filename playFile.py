#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# play a wav file
import sounddevice as sd
import soundfile as sf
print("here is sd")
print(sd)
devs = sd.query_devices()
print("here are the devices")
print(devs)

data, fs = sf.read("PinkPanther30_a.wav", dtype = "float32")
print("sample rate=",fs)
sd.play(data, fs)
sd.wait()

sudo sh get-docker.sh
