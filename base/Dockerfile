# This file sets up a Docker image that can run the WRECS DRC workspace
# on 12.04, and hopefully allow the use of CUDA with newer NVidia
# graphics cards that don't have Ubuntu 12.04 drivers (GTX 9xx series/GTX
# Titan X
#
# Alec Thompson, 2015
#

FROM ubuntu:precise
MAINTAINER Alec Thompson "ajthompson042@gmail.com"
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get dist-upgrade -y

# Set the env variable DEBIAN_FRONTEND to noninteractive
ENV TERM xterm
ENV DEBIAN_FRONTEND noninteractive
ENV HOME /home/wrecs
# Necessary for QT-apps/gazebo controls
ENV QT_X11_NO_MITSHM 1
#RUN echo "export TERM=xterm" >> /etc/profile
#RUN echo "export DEBIAN_FRONTEND=noninteractive" >> /etc/profile

# install necessary files for remote GUI
RUN apt-get install -y apt-utils sudo software-properties-common python-software-properties wget git language-pack-en 

# Upstart and DBus have issues inside docker. We work around in order to install firefox.
RUN dpkg-divert --local --rename --add /sbin/initctl && ln -sf /bin/true /sbin/initctl

# Setup wrecs user
RUN useradd -b /home -m wrecs
RUN echo 'wrecs:wrecs' | chpasswd
RUN echo 'root:root' | chpasswd

# ubuntu precise image doesn't have universe repo
RUN add-apt-repository "deb http://archive.ubuntu.com/ubuntu precise main universe restricted multiverse"

# SSH setup based on https://docs.docker.com/engine/examples/running_ssh_service/
# set up ssh daemon
RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd
#RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Run WRECS stuff
#RUN sudo -H -u wrecs bash -c 'bash /home/wrecs/install_scripts/install.bash'

###############
#### WRECS ####
###############

## Add repositories
RUN apt-add-repository -y ppa:openrave/testing
RUN sh -c 'echo "deb http://packages.osrfoundation.org/drc/ubuntu precise main" > /etc/apt/sources.list.d/drc-latest.list'
RUN wget http://packages.osrfoundation.org/drc.key -O - | sudo apt-key add -
RUN sh -c 'echo "deb http://packages.ros.org/ros-shadow-fixed/ubuntu precise main" > /etc/apt/sources.list.d/ros-latest.list'
RUN wget https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -O - | apt-key add -

## Update repositories
RUN apt-get update

## Install non-ros dependencies
RUN apt-get install -y aptitude libbobcat-dev libx264-120 kdelibs5-dev python-pip libboost-random-dev
RUN apt-get install -y libopenscenegraph-dev cmake libeigen3-dev python-numpy python3.2-dev libsuitesparse-dev
RUN apt-get install -y freeglut3-dev libglu-dev libglew-dev gnuplot python-dev zip unzip

## Install dependencies with pip
RUN pip install -U pymodbus

## Install Openrave
RUN apt-get install -y openrave

## Install ROS Hydro
RUN aptitude install ros-hydro-desktop-full -y
RUN rosdep init
RUN sudo -H -u wrecs bash -c 'rosdep update'

## install ros packages that are needed
RUN apt-get install -y ros-hydro-qt-ros ros-hydro-multisense ros-hydro-razer-hydra ros-hydro-camera-info-manager-py
RUN apt-get install -y ros-hydro-moveit-ros ros-hydro-moveit-full ros-hydro-fcl ros-hydro-ar-track-alvar
RUN apt-get install -y ros-hydro-pr2-mechanism ros-hydro-axis-camera ros-hydro-roslint ros-hydro-joy ros-hydro-sbpl
RUN apt-get install -y ros-hydro-octomap-ros ros-hydro-libg2o

## Install g2o fix
RUN sudo -H -u wrecs bash -c 'mkdir ~/Downloads; \
	cd ~/Downloads; \
	wget http://www.dropbox.com/s/l0q4oc7yuk00t92/if_g2o_is_missed.zip; \
	unzip if_g2o_is_missed.zip'
RUN mv /home/wrecs/Downloads/if_g2o_is_missed/cmake /opt/ros/hydro/share/libg2o/
RUN sudo -H -u wrecs bash -c 'cd ~/Downloads; \
	rm -rf if_g2o_is_missed; \
	rm if_g2o_is_missed.zip;'

## Install gurobi
RUN sudo -H -u wrecs bash -c 'cd ~/Downloads; \
	wget https://dl.dropboxusercontent.com/u/30063350/gurobi6.0.5_linux64.tar.gz; \
	tar xf ~/Downloads/gurobi6.0.5_linux64.tar.gz'
RUN mv /home/wrecs/Downloads/gurobi605 /opt
RUN sudo -H -u wrecs bash -c 'cd ~/Downloads; \
	rm -f gurobi6.0.5_linux64.tar.gz; \
	rm -rf gurobi605; \
	echo 'export GUROBI_HOME=/opt/gurobi605/linux64' >> ~/.bashrc'

## Install flycapture
RUN apt-get install -y libraw1394-11 libgtk2.0-0 libgtkmm-2.4-dev libglademm-2.4-dev 
RUN apt-get install -y libgtkglextmm-x11-1.2-dev libusb-1.0-0 build-essential
RUN sudo -H -u wrecs bash -c 'cd ~/Downloads; \
	wget -N https://raw.github.com/WPI-Atlas-Lab/AtlasLab/master/flycapture2-2.7.3.19-amd64-pkg.tgz; \
	tar xvf flycapture2-2.7.3.19-amd64-pkg.tgz'
RUN dpkg -i /home/wrecs/Downloads/flycapture2-2.7.3.19-amd64/libflycapture-2*
RUN dpkg -i /home/wrecs/Downloads/flycapture2-2.7.3.19-amd64/libflycapturegui-2*
RUN dpkg -i /home/wrecs/Downloads/flycapture2-2.7.3.19-amd64/libflycapture-c-2*
RUN dpkg -i /home/wrecs/Downloads/flycapture2-2.7.3.19-amd64/libflycapturegui-c-2*
RUN dpkg -i /home/wrecs/Downloads/flycapture2-2.7.3.19-amd64/libmultisync-2*
RUN dpkg -i /home/wrecs/Downloads/flycapture2-2.7.3.19-amd64/flycap-2*
RUN dpkg -i /home/wrecs/Downloads/flycapture2-2.7.3.19-amd64/flycapture-doc-2*
RUN dpkg -i /home/wrecs/Downloads/flycapture2-2.7.3.19-amd64/updatorgui*
RUN groupadd -f pgrimaging
RUN usermod -a -G pgrimaging wrecs
RUN /etc/init.d/udev restart
# Now lets not notify the server, because they made an inconvenient interactive only
# install script

## Install DRCsim
RUN apt-get install -y drcsim-hydro

## Install useful software
RUN apt-get install -y gconf-service libgconf-2-4 libnspr4 libnss3 libappindicator1
RUN sudo -H -u wrecs bash -c 'cd ~/Downloads; \
	wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb'
RUN dpkg -i /home/wrecs/Downloads/google-chrome-stable_current_amd64.deb
RUN apt-get install -y terminator qtcreator stress fping iftop lm-sensors vm emacs htop
RUN apt-get install -y gimp gitg gitk screen tshark wireshark ntp vim
RUN apt-get install -y openjdk-7-jre openjdk-7-jdk
RUN sudo -H -u wrecs bash -c 'cd ~/Downloads; \
	wget http://eclipse.bluemix.net/packages/mars.1/data/eclipse-cpp-mars-1-linux-gtk-x86_64.tar.gz; \
	tar xvf eclipse-cpp-mars-1-linux-gtk-x86_64.tar.gz'
RUN mv /home/wrecs/Downloads/eclipse /opt
RUN echo '[Desktop Entry]' >> /usr/share/applications/eclipse.desktop
RUN echo 'Name=Eclipse' >> /usr/share/applications/eclipse.desktop
RUN echo 'Type=Application' >> /usr/share/applications/eclipse.desktop
RUN echo 'Exec=/opt/eclipse/eclipse' >> /usr/share/applications/eclipse.desktop
RUN echo 'Terminal=false' >> /usr/share/applications/eclipse.desktop
RUN echo 'Icon=/opt/eclipse/icon.xpm' >> /usr/share/applications/eclipse.desktop
RUN echo 'Comment=Integrated Development Environment' >> /usr/share/applications/eclipse.desktop
RUN echo 'NoDisplay=false' >> /usr/share/applications/eclipse.desktop
RUN echo 'Categories=Development;IDE' >> /usr/share/applications/eclipse.desktop
RUN echo 'Name[en]=Eclipse' >> /usr/share/applications/eclipse.desktop
RUN ln -s /opt/eclipse/eclipse /usr/local/bin/eclipse

## Copy over users ssh key
RUN mkdir /home/wrecs/.ssh
RUN chown wrecs /home/wrecs/.ssh
ADD id_rsa /home/wrecs/.ssh/id_rsa
ADD id_rsa.pub /home/wrecs/.ssh/id_rsa.pub
RUN chown wrecs /home/wrecs/.ssh/id_rsa
RUN chown wrecs /home/wrecs/.ssh/id_rsa.pub
RUN chmod 600 /home/wrecs/.ssh/id_rsa
RUN chmod 600 /home/wrecs/.ssh/id_rsa.pub
RUN \ 
  echo "IdentityFile /home/wrecs/.ssh/id_rsa" >> /etc/ssh/ssh_config && \  
  echo -e "StrictHostKeyChecking no" >> /etc/ssh/ssh_config

## Setup DRC workspace
RUN apt-get install -y python-rosinstall python-wstool symlinks
RUN echo "Creating workspace."
RUN sudo -H -u wrecs bash -c 'source ~/.bashrc; \
	mkdir -p ~/drc_workspace/src; \
        cd ~/drc_workspace/src; \
	source /opt/ros/hydro/setup.sh; \
	printenv | grep ROS; \
        catkin_init_workspace'
RUN echo "Making workspace."
RUN sudo -H -u wrecs bash -c 'cd ~/drc_workspace; \
	source /opt/ros/hydro/setup.sh; \
        catkin_make'
RUN echo "Adding sources."
RUN sudo -H -u wrecs bash -c 'cd ~/drc_workspace/src; \
	wstool init; \
	wstool set drc git@github.com:WPI-Humanoid-Research-Lab/drc --git -y; \
	wstool update'
RUN echo "Finished adding sources."
ADD sample_bashrc /home/wrecs/sample_bashrc
RUN cat /home/wrecs/sample_bashrc >> /home/wrecs/.bashrc
RUN rm -f /home/wrecs/sample_bashrc

## Install m100
RUN dpkg -i /home/wrecs/drc_workspace/src/drc/sentis_tof_m100_pkg/m100api-1.0.0-Linux-amd64.deb

## Download and copy over libAtlasSimInterface.so
RUN sudo -H -u wrecs bash -c 'cd ~/Downloads; \
	wget https://dl.dropboxusercontent.com/u/30063350/AtlasSimInterface_3.0.2.tar.gz; \
	tar xvf AtlasSimInterface_3.0.2.tar.gz'
RUN mv /home/wrecs/Downloads/AtlasSimInterface_3.0.2/lib64/libAtlasSimInterface.so.3.0.2 /opt/ros/hydro/lib/libAtlasSimInterface3.so.3.0.2

## Build the workspace
RUN sudo -H -u wrecs bash -c 'cd ~/drc_workspace; \
	source ~/.bashrc; \
	source /opt/ros/hydro/setup.sh; \
	source /usr/share/drcsim/setup.sh; \
	source ~/drc_workspace/devel/setup.bash; \
	export ATLAS_ROBOT_INTERFACE=~/drc_workspace/src/drc/bdi_api/AtlasRobotInterface; \
	export LD_LIBRARY_PATH="${LD_LIBRARY_PATH}":"${ATLAS_ROBOT_INTERFACE}"/lib64/; \
	export GAZEBO_PLUGIN_PATH=~/drc_workspace/devel/lib:"${GAZEBO_PLUGIN_PATH}"; \
	export GAZEBO_MODEL_PATH=~/drc_workspace/src/drc/field/robotiq:"${GAZEBO_MODEL_PATH}"; \
	export PYTHONPATH=~/drc_workspace/src/drc/trajopt/build_trajopt/lib:~/drc_workspace/src/drc/trajopt:"${PYTHONPATH}"; \
	export LD_LIBRARY_PATH="${LD_LIBRARY_PATH}":/usr/lib; \
	export GUROBI_HOME=/opt/gurobi605/linux64; \
	export OPENRAVE_DATA="${OPENRAVE_DATA}":~/drc_workspace/src/drc/trajopt/; \
	catkin_make -j8'

## Expose port and start ssh daemon
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]

########################
#### X11 FORWARDING ####
########################

# This will allow us to access the Atlas GUI, and any other gui applications

# Installing the environment required: xserver, xdm, flux box, roc-filer and ssh
RUN apt-get install -y xpra rox-filer openssh-server pwgen xserver-xephyr xdm fluxbox xvfb sudo

# Configuring xdm to allow connections from any IP address and ssh to allow X11 Forwarding. 
RUN sed -i 's/DisplayManager.requestPort/!DisplayManager.requestPort/g' /etc/X11/xdm/xdm-config
RUN sed -i '/#any host/c\*' /etc/X11/xdm/Xaccess
RUN ln -s /usr/bin/Xorg /usr/bin/X
RUN echo X11Forwarding yes >> /etc/ssh/ssh_config

