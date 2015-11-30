# This file installs the newest available nvidia drivers on ubuntu 12.04
# It provides support for GTX 980 Ti's and other Maxwell cards (Titan X, etc)
#
# Modify this file to match the drivers installed on the host system
#
# Alec Thompson, 2015
#

FROM networking/whrl:latest
MAINTAINER Alec Thompson "ajthompson042@gmail.com"

# Add repository for precise backport of Nvidia drivers
RUN apt-add-repository "deb http://ppa.launchpad.net/spvkgn/gpu-drivers/ubuntu precise main"
RUN apt-get update

# INstall Nvidia proprietary driver 352.63
RUN apt-get install -y nvidia-352


