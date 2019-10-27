# Dockerfile to setup sounddevices on Rpi

#https://www.balena.io/docs/learn/develop/dockerfile/
FROM balenalib/raspberry-pi-node

# enable container init system.
ENV INITSYSTEM on


MAINTAINER Val <vveirs@coloradocollege.edu>

#upgrade OS
RUN apt-get update && apt-get upgrade -y -o Dpkg::Options::="--force-confold"

# Set default command to bash as a placeholder
CMD ["/bin/bash"]

# Make sure we're the root user
USER root

WORKDIR /root

RUN apt-get update && apt-get install -y --no-install-recommends \
    # General tools
    htop \
    nano \
    sox \
    tmux \
    wget

#install ALSA
RUN apt-get install alsa-base alsa-oss alsa-utils alsa-tools mpg123
RUN apt-get install libasound-dev

#get and compile portaudio
RUN ["wget", "http://www.portaudio.com/archives/pa_stable_v190600_20161030.tgz"]
RUN tar xzf pa_stable_v190600_20161030.tgz
RUN ls
RUN pwd
RUN ["cd", "portaudio"]
RUN ls
RUN pwd
RUN ["./configure"]
RUN ["make"]


#install Python and pip
RUN apt-get install python3
RUN apt-get install python3-pip

#install sounddevice
RUN python3 -m pip3 install sounddevice

#list sound devices
RUN python3 -m sounddevice

#run a python script
ADD PinkPanther30_a.wav /
ADD playFile.py /
CMD python3 playFile.py 

