#!/bin/bash

FROM resin/raspberry-pi-node:8

MAINTAINER Val V <vveirs@coloradocollege.edu>

#upgrade OS
RUN apt-get update && apt-get upgrade -y -o Dpkg::Options::="--force-confold"

#install ALSA
RUN apt-get install alsa-base alsa-oss alsa-utils alsa-tools mpg123
RUN apt-get install libasound-dev


# Set default command to bash as a placeholder
CMD ["/bin/bash"]

#install Python and pip  I guess this is pip3
RUN apt-get install python3-dev
RUN apt-get install python3-pip
RUN echo $(which pip3)

RUN apt-get install apt-utils
RUN apt-get install python3-numpy

#install portaudio
RUN apt-get install libportaudio2

RUN apt-get autoremove

#install sounddevice and SoundFile
RUN pip3 install sounddevice
RUN apt-get install libsndfile1
RUN pip3 install SoundFile

ADD playFile.py /
ADD PinkPanther30_a.wav /
RUN echo "\n.\n.\n..............................ls"
RUN echo $(ls)
#RUN ["python3", "playFile.py"]

