# Based on official
FROM ubuntu:20.10

# Install Software Properties
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get -y install software-properties-common

# Install C Build Tools
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get -y install build-essential make

# Install Java 16
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get -y install openjdk-16-jdk

# Install FFMPEG
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get -y install ffmpeg

# Install GPAC (MP4BOX)
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get -y install gpac

# Install Bento4 from local binaries
ADD ./.vendor/Bento4-SDK-1-6-0-639.x86_64-unknown-linux.zip /opt/bento4
ENV PATH="/opt/bento4/bin:${PATH}"
