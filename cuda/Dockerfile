# Install CUDA 7.5
# This can be modified to install an earlier version of CUDA if necessary -
# the main requirement is that the CUDA versions on the host and container
# match

FROM nvidia-drivers/whrl:latest
MAINTAINER Alec Thompson "atjhompson042@gmail.com"

# Add CUDA repo from Nvidia sites
#RUN cd /home/wrecs/Downloads; wget http://developer.download.nvidia.com/compute/cuda/7.5/Prod/local_installers/cuda-repo-ubuntu1404-7-5-local_7.5-18_amd64.deb
#RUN dpkg -i /home/wrecs/Downloads/cuda-repo-ubuntu1404-7-5-local_7.5-18_amd64.deb
#RUN apt-get update

## Install dependencies for CUDA driver
#RUN mkdir /downloads
# fontconfig-config
#RUN cd /downloads; wget http://ftp.us.debian.org/debian/pool/main/f/fontconfig/fontconfig-config_2.11.0-6.3_all.deb
#RUN dpkg -i /downloads/fontconfig-config_2.11.0-6.3_all.deb
# libfontconfig1
#RUN cd /downloads; wget http://ftp.us.debian.org/debian/pool/main/f/fontconfig/libfontconfig1_2.11.0-6.3_amd64.deb
#RUN dpkg -i /downloads/libfontconfig1_2.11.0-6.3_amd64.deb
# libjansson4
#RUN cd /downloads; wget http://ftp.us.debian.org/debian/pool/main/j/jansson/libjansson4_2.7-1_amd64.deb
#RUN dpkg -i /downloads/libjansson4_2.7-1_amd64.deb
# libc-bin
#RUN cd /downloads; wget http://ftp.us.debian.org/debian/pool/main/g/glibc/libc-bin_2.19-18+deb8u1_amd64.deb
#RUN dpkg -i /downloads/libc-bin_2.19-18+deb8u1_amd64.deb
# locales
#RUN cd /downloads; wget http://ftp.us.debian.org/debian/pool/main/g/glibc/locales_2.19-18+deb8u1_all.deb
#RUN dpkg -i --force-overwrite /downloads/locales_2.19-18+deb8u1_all.deb
# libc6
#RUN cd /downloads; wget http://ftp.us.debian.org/debian/pool/main/g/glibc/libc6_2.19-18+deb8u1_amd64.deb
#RUN dpkg -i --auto-deconfigure /downloads/libc6_2.19-18+deb8u1_amd64.deb
#RUN dpkg -i /downloads/libc-bin_2.19-18+deb8u1_amd64.deb /downloads/locales_2.19-18+deb8u1_all.deb /downloads/libc6_2.19-18+deb8u1_amd64.deb
# libglib2.0-0
#RUN cd /downloads; wget http://ftp.us.debian.org/debian/pool/main/g/glib2.0/libglib2.0-0_2.42.1-1_amd64.deb
#RUN dpkg -i --auto-deconfigure /downloads/libglib2.0-0_2.42.1-1_amd64.deb
# libpango-1.0-0
#RUN cd /downloads; wget http://ftp.us.debian.org/debian/pool/main/p/pango1.0/libpango-1.0-0_1.36.8-3_amd64.deb
#RUN dpkg -i --auto-deconfigure /downloads/libpango-1.0-0_1.36.8-3_amd64.deb
# libpangocairo-1.0-0
#RUN cd /downloads; wget http://ftp.us.debian.org/debian/pool/main/p/pango1.0/libpangocairo-1.0-0_1.36.8-3_amd64.deb
#RUN dpkg -i /downloads/libpangocairo-1.0-0_1.36.8-3_amd64.deb
# libpangoft2-1.0-0
#RUN cd /downloads; wget http://ftp.us.debian.org/debian/pool/main/p/pango1.0/libpangoft2-1.0-0_1.36.8-3_amd64.deb
#RUN dpkg -i /downloads/libpangoft2-1.0-0_1.36.8-3_amd64.deb

# Set CUDA versions to use
ENV CUDA_V_ 7_5
ENV CUDA_V 7.5
ENV CUDA_VERSION 7.5.18
ENV CUDA_INSTALL_URL http://developer.download.nvidia.com/compute/cuda/7.5/Prod/local_installers/cuda_7.5.18_linux.run

# Install dependencies
RUN apt-get update && \
  apt-get install -y wget build-essential module-init-tools && \
  rm -rf /var/lib/apt/lists/*

# Download and install CUDA
RUN cd /tmp && \
  wget $CUDA_INSTALL_URL && \
  chmod +x /tmp/cuda*.run && \
  mkdir nvidia_installer && \
  ./cura*.run -extract=/tmp/nvidia_installer && \
  cd nvidia_installer && \ 
  ./NVIDIA*.run --silent --no-network --no-kernel-module && \
  ./cuda*.run -noprompt && \
  rm -rf /tmp/*

# Ensure the cuda libraries are in the right directories
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda/lib64
ENV PATH=$PATH:/usr/local/cuda/bin
RUN ldconfig


