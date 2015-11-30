#!/bin/bash

BASE_DIRECTORY=$(pwd)
export BASE_DIRECTORY

# Overall control script to build the docker images
./base/setup_ssh.bash
./base/build_base.bash
./networking/build_networking.bash
./nvidia-drivers/build_nvidia_drivers.bash
#./cuda/build_cuda.bash
./final/build_final.bash

exit 0

