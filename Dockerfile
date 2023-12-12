#!/bin/bash

#FROM resin/raspberry-pi-node:8
#FROM arm32v7/python:3.7-buster
# for Non-Rpi computer
#FROM python:3.10-slim-buster  
# for Rpi and Balena
FROM balenalib/raspberrypi4-64-ubuntu:latest
MAINTAINER Val V <vveirs@coloradocollege.edu>

# upgrade OS
RUN apt update
RUN apt upgrade -y 
# -o Dpkg::Options::="--force-confold"
RUN apt install -y apt-utils

#install ALSA   ### MAYBE don't need this with buster
#RUN apt install -y alsa-base
RUN apt install -y alsa-oss alsa-utils alsa-tools mpg123
RUN apt install -y libasound-dev

# Set default command to bash as a placeholder
CMD ["/bin/bash"]

#install Python and pip  I guess this is pip3
RUN apt install -y python3-dev
RUN apt install -y python3-pip

RUN echo $(which pip3)

RUN pip3 install numpy

#install portaudio
RUN apt install -y libportaudio2

RUN apt autoremove

#install sounddevice and SoundFile
RUN pip3 install sounddevice
RUN apt install -y libsndfile1
RUN pip3 install SoundFile

#COPY playFile.py ./
#ADD playFile.py /
COPY hydrolisten.py ./
ADD hydrolisten.py /


#ADD PinkPanther30_a.wav /
#RUN echo "\n.\n.\n..............................ls"
#RUN echo $(ls)
#RUN ["python3", "playFile.py"]  # this should play the wav file on the default output port

#RUN ["python3", "hydrolisten.py -i 'hw:1,0' -o 'hw:1,0' -c 1 -s 48000 -a 0.05 -v 2" ]
#RUN ["python3", "hydrolisten.py"]

