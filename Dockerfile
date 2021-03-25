#!/bin/bash

#FROM resin/raspberry-pi-node:8
FROM arm32v7/python:3.7-buster

MAINTAINER Val V <vveirs@coloradocollege.edu>

#upgrade OS
RUN apt-get update && apt-get upgrade -y -o Dpkg::Options::="--force-confold"
RUN apt-get install -y apt-utils

#install ALSA   ### MAYBE don't need this any longer with buster
#RUN apt-get install -y alsa-base
RUN apt-get install -y alsa-oss alsa-utils alsa-tools mpg123
RUN apt-get install -y libasound-dev

# Set default command to bash as a placeholder
CMD ["/bin/bash"]

#install Python and pip  I guess this is pip3
RUN apt-get install -y python3-dev
RUN apt-get install -y python3-pip
RUN echo $("which pip3")
RUN echo $(which pip3)    #  WHY IS pip3 NOT reporting its location?  It is used to install stuff below

RUN pip3 install numpy

#install portaudio
RUN apt-get install -y libportaudio2

RUN apt-get autoremove

#install sounddevice and SoundFile
RUN pip3 install sounddevice
RUN apt-get install -y libsndfile1
RUN pip3 install SoundFile

COPY playFile.py ./
ADD playFile.py /
COPY wireALC_3.py ./
ADD wireALC_3.py /


ADD PinkPanther30_a.wav /
RUN echo "\n.\n.\n..............................ls"
RUN echo $(ls)
#RUN ["python3", "playFile.py"]  # this should play the wav file on the default output port

