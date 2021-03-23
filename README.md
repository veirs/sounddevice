README file

This docker file is used to build an image that installs libraries needed to run 
    sounddevices in python3 ( https://python-sounddevice )

Libraries and programs include libsound, python3, pip3, numpy, portaudio, sounddevice, SoundFile

It seems that these should allow an image to be built that will run on a RaspberryPi 3B

docker commands:
docker build -t "docker_sd_0:v1" .
docker container run --privileged -d docker_sd_0:v1
