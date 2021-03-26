README file

This docker file is used to build an image that installs libraries needed to run 
    sounddevices in python3 ( https://python-sounddevice )
    
Commands to build are listed in commandList.txt file

Libraries and programs include libsound, python3, pip3, numpy, portaudio, sounddevice, SoundFile

It seems that these should allow an image to be built that will run on a RaspberryPi 3B

docker commands:

docker build -t "docker_sd_0:v1" .

docker run -it --device /dev/snd 781102bbff60 bin/bash  % number is container created by docker build

python hydrolisten.py   # to run the script


