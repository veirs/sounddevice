README file
This docker file is used by balena-cloud to build an image that installs libraries needed to run 
    sounddevices in python3 ( https://python-sounddevice )

Libraries and programs include ALSA, python3, pip3, numpy, portaudio, sounddevice, SoundFile

It seems that these allow an image to be built that will run (sort of) on a RaspberryPi 3B

But...........


-------------------------Here is a screen grab from balena-cloud's terminal window where I started
   python3 and then pasted in the code that is in the playFile.py file

   Listening with ear phones is sounds great :)

Spawning shell...
root@067a8ce:/# python3
Python 3.4.2 (default, Sep 16 2019, 19:58:00) 
[GCC 4.9.2] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> # play a wav file
... import sounddevice as sd
>>> import soundfile as sf
>>> data, fs = sf.read("PinkPanther30_a.wav", dtype = "float32")
>>> print("sample rate=",fs)
sample rate= 44100
>>> sd.play(data, fs)
>>> exit()

-----------------------However, when the playFile.py file is called directly, the sample rate is printed but
    no sound comes from the ear phones

root@067a8ce:/# python3 playFile.py
sample rate= 44100

-----------------------And,if the file is executed directly, again, the sound  does not play

root@067a8ce:/# ./playFile.py
sample rate= 44100

root@067a8ce:/# 
